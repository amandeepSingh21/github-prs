//
//  PRCommitsPresenter.swift
//  GithubPRs
//
//  Created by Amandeep on 15/01/23.
//

import Foundation

protocol PRCommitsPresenterProtocol {
    func load()
    func loadMore()
    func refresh()
    func didSelect(commit: PRCommitViewModel)
    var commits: [PRCommitViewModel] { get }
    var paginator: Paginator? { get }
    ///Modified Viper: Using Observables we have eliminated Presnter -> View protocol
    var viewState: Observable<PullRequestViewState> { get }
    var indexPathsToReload: Observable<[IndexPath]?>  { get }
    var resetScrollViewOffset: Observable<Bool> { get }
}


final class PRCommitsPresenter: PRCommitsPresenterProtocol {
    //MARK: State
    private var pullRequest: PullRequestViewModel
    private(set) var commits: [PRCommitViewModel] = []

    //MARK: Presenter to view controller communication
    var viewState: Observable<PullRequestViewState> = Observable(PullRequestViewState.notLoaded)
    //MARK: Presenter to view communication
    var indexPathsToReload: Observable<[IndexPath]?> = Observable(nil)
    var fullReload:Observable<Bool> = Observable(false)
    var resetScrollViewOffset: Observable<Bool> = Observable(false)
    
    //MARK: Dependencies
    ///Abstraction for pagination
    var paginator: Paginator? {
        didSet { self.commits = [] }
    }
    
    private let wireframe: PRCommitsWireframeInterface
    private let interactor: PRCommitsInteractorProtocol

    //MARK: Init
    init(wireframe: PRCommitsWireframeInterface,
         interactor: PRCommitsInteractorProtocol,
         pullRequest: PullRequestViewModel
    ) {
        self.wireframe = wireframe
        self.interactor = interactor
        self.pullRequest = pullRequest
    }
    
    //MARK: Query
    func load() {
        self.paginator = Paginator()
        self.paginator?.delegate = self
        self.viewState.value = .loading("Commits")
        self.resetScrollViewOffset.value = true
        self.paginator?.loadData()
    }

    //MARK: Paginate
    func loadMore() {
        self.paginator?.loadData()
    }

    //MARK: TableView RefreshControl
    func refresh() {
        self.interactor.cancelRequest()
        self.paginator?.loadData(refresh: true)
    }
}

//MARK: Pagination handler
extension PRCommitsPresenter: PaginationDelegate {
    ///Callback from `loadData()` which in turn calls back `reload(indexPath:)` based on api succes or failure
    func loadMore(_ pageNumber: Int, onSuccess: (([Any]) -> Void)?, onError: ((Error) -> Void)?) {
        //API Call
        guard let apiRequest = PRCommit.api(pr: pullRequest, page: .init(page: pageNumber)) else { return }
        self.interactor.load(apiRequest) { [weak self] result in
            switch result {
            case .success(let comments):
                self?.handleSuccess(comments)
                onSuccess?(comments)
            case .failure(let error):
                self?.handleError(error)
                onError?(error)
            }
        }
    }
    
    func reload(indexPaths: [IndexPath]) {
        self.indexPathsToReload.value = indexPaths
    }
    
}


//MARK: Navigation
extension PRCommitsPresenter {
    func didSelect(commit: PRCommitViewModel) {
        self.wireframe.showCommitDetailScreen(commit.htmlURL)
    }
}

extension PRCommitsPresenter {
    func handleSuccess(_ result: [PRCommitViewModel]) {
        if paginator?.isRefreshing ?? false {
            self.commits = result
        } else {
            self.commits = self.commits + result
        }
        if self.commits.isEmpty {
            self.viewState.value = .noResultsFound
        } else {
            self.viewState.value = .loaded
        }
    }
    
    func handleError(_ error: ErrorViewModel) {
        self.viewState.value = .error(error)
    }
}
