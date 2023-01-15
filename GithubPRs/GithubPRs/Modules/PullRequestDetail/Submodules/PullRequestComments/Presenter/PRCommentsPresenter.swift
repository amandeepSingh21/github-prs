//
//  PRCommentsPresenter.swift
//  GithubPRs
//
//  Created by Amandeep on 15/01/23.
//

import Foundation

protocol PRCommentsPresenterProtocol {
  
    func load()
    func loadMore()
    func refresh()
    func didSelect(comment: PRCommentViewModel)
    var comments: [PRCommentViewModel] { get }
    var paginator: Paginator? { get }
    ///Modified Viper: Using Observables we have eliminated Presnter -> View protocol
    var viewState: Observable<PullRequestViewState> { get }
    var indexPathsToReload: Observable<[IndexPath]?>  { get }
    var resetScrollViewOffset: Observable<Bool> { get }
    
}


class PRCommentsPresenter: PRCommentsPresenterProtocol {
    //MARK: State
    private var pullRequest: PullRequestViewModel
    private(set) var comments: [PRCommentViewModel] = []

    //MARK: Presenter to view controller communication
    var viewState: Observable<PullRequestViewState> =  Observable(PullRequestViewState.notLoaded)
    //MARK: Presenter to view communication
    var indexPathsToReload: Observable<[IndexPath]?> = Observable(nil)
    var fullReload:Observable<Bool> = Observable(false)
    var resetScrollViewOffset: Observable<Bool> = Observable(false)
    
    //MARK: Dependencies
    ///Abstraction for pagination
    var paginator: Paginator? {
        didSet { self.comments = [] }
    }
    
    private let wireframe: PRCommentsWireframe
    private let interactor: PRCommentsInteractorProtocol

    //MARK: Init
    init(wireframe: PRCommentsWireframe,
         interactor: PRCommentsInteractorProtocol,
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
        self.viewState.value = .loading("Comments")
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
extension PRCommentsPresenter: PaginationDelegate {
    ///Callback from `loadData()` which in turn calls back `reload(indexPath:)` based on api succes or failure
    func loadMore(_ pageNumber: Int, onSuccess: (([Any]) -> Void)?, onError: ((Error) -> Void)?) {
        //API Call
        guard let apiRequest = PRComment.api(pr: pullRequest, page: .init(page: pageNumber)) else { return }
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
extension PRCommentsPresenter {
    func didSelect(comment: PRCommentViewModel) {
    }
}

extension PRCommentsPresenter{
    func handleSuccess(_ result: [PRCommentViewModel]) {
        if paginator?.isRefreshing ?? false {
            self.comments = result
        } else {
            self.comments = self.comments + result
        }
        if self.comments.isEmpty {
            self.viewState.value = .noResultsFound
        } else {
            self.viewState.value = .loaded
        }
    }
    
    func handleError(_ error: ErrorViewModel) {
        self.viewState.value = .error(error)
    }
}

