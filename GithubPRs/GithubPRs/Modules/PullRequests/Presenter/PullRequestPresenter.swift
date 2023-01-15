//
//  PullRequestPresenter.swift
//  GithubPRs
//
//  Created by Amandeep on 14/01/23.
//

import Foundation

protocol PullRequestPresenterProtocol {
    ///Following are the 4 operations available on presenter:
    func load(organisation: String, repo: String) ///To load with a new search query
    func loadMore() ///To paginate existing query
    func refresh() ///To re-load existing query. Called by UITableView from PullRequestView
    func didSelect(pullRequest: PullRequestViewModel) ///To open detail page. Called by UITableView from PullRequestListView
    
    var pullRequests: [PullRequestViewModel] { get } ///Datasource for table view
    var page: Int { get } ///Used by table view to make decison b/w fullReload or optimisedRelaod
    
    ///Modified Viper: Using Observables we have eliminated Presnter -> View protocol
    var viewState: Observable<PullRequestViewState> { get } ///This is listened by the PullRequestController to decide view state
    var indexPathsToReload: Observable<[IndexPath]?>  { get }  ///This is listened by the PullRequestView for optmised cell reload
    var resetScrollViewOffset: Observable<Bool> { get }  ///This is listened by the PullRequestView to reset table view contentOffset
    
}


class PullRequestPresenter: PullRequestPresenterProtocol {        
    //MARK: State
    private var organisationName: String = "apple"
    private let screenType: PullRequestScreenType
    private var repoName: String = "swift"
    private(set) var pullRequests: [PullRequestViewModel] = []
    var page: Int { self.paginator?.page ?? 0 }
    
    //MARK: Presenter to view controller communication
    var viewState: Observable<PullRequestViewState> =  Observable(PullRequestViewState.notLoaded)
    //MARK: Presenter to view communication
    var indexPathsToReload: Observable<[IndexPath]?> = Observable(nil)
    var fullReload:Observable<Bool> = Observable(false)
    var resetScrollViewOffset: Observable<Bool> = Observable(false)
    
    //MARK: Dependencies
    ///Abstraction for pagination
    private var paginator: Paginator? {
        didSet { self.pullRequests = [] }
    }
    
    private let wireframe: PullRequestWireframe
    private let interactor: PullRequestInteractor

    //MARK: Init
    init(wireframe: PullRequestWireframe, interactor: PullRequestInteractor, screenType: PullRequestScreenType) {
        self.wireframe = wireframe
        self.screenType = screenType
        self.interactor = interactor
    }
    
    //MARK: Query
    func load(organisation: String, repo: String) {
        self.organisationName = organisation
        self.repoName = repo
        self.paginator = Paginator()
        self.paginator?.delegate = self
        self.viewState.value = .loading(repo)
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
extension PullRequestPresenter: PaginationDelegate {
    ///Callback from `loadData()` which in turn calls back `reload(indexPath:)` based on api succes or failure
    func loadMore(_ pageNumber: Int, onSuccess: (([Any]) -> Void)?, onError: ((Error) -> Void)?) {
        //API Call
        let apiRequest = PullRequest.api(organization: organisationName,
                                         repo: repoName, status: screenType.apiValue,
                                         page: .init(page: pageNumber))
        self.interactor.load(apiRequest) { [weak self] result in
            switch result {
            case .success(let prs):
                self?.handleSuccess(prs)
                onSuccess?(prs)
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
extension PullRequestPresenter {
    func didSelect(pullRequest: PullRequestViewModel) {
        self.wireframe.showPullRequestDetailScreen(pullRequest)
    }
}

extension PullRequestPresenter{
    func handleSuccess(_ result: [PullRequestViewModel]) {
        if paginator?.isRefreshing ?? false {
            self.pullRequests = result
        } else {
            self.pullRequests = self.pullRequests + result
        }
        if self.pullRequests.isEmpty {
            self.viewState.value = .noResultsFound
        } else {
            self.viewState.value = .loaded
        }
    }
    
    func handleError(_ error: ErrorViewModel) {
        self.viewState.value = .error(error)
    }
}

