//
//  Paginator.swift
//  GithubPRs
//
//  Created by Amandeep on 14/01/23.
//

import Foundation

protocol PaginationDelegate: AnyObject {
    ///On API success, returns indexPaths to reload
    func reload(indexPaths:[IndexPath])
    ///Return  pageNumber  to use for the API after `loadData()`
    ///  - Parameters:
    ///     - onSuccess: Must be called after API success to update pagination state
    ///     - onFailure: Must be called after API failure to update pagination state

    func loadMore(_ pageNumber: Int, onSuccess: (([Any]) -> Void)?, onError: ((Error) -> Void)?)
   
}

protocol Pagination: AnyObject {
    func loadData(refresh: Bool)
    var canLoadMore: ((Bool) -> Void)? { get }
}
    
///Paginator is used to maintain  pagination state
///It has two responsiblities:
///1. Keep track of pagiantion state
///2. Calculating indexPaths to reload
class Paginator: Pagination {
    var canLoadMore: ((Bool) -> Void)?
    //MARK:- Private Properties
    private var isLoading: Bool = false
    private(set) var page: Int = 1
    private var dataSource: [Any] = []
    //MARK:- Public Property
    weak var delegate: PaginationDelegate?
    private var couldLoadMore: Bool = true  {
        didSet {
            canLoadMore?(couldLoadMore)
        }
    }
    var isRefreshing: Bool = false
    
    //MARK:- Methods
    ///Returns page number for the API using `PaginationDelegate` delegate
    ///Calculates and returns indexPaths to reload using `PaginationDelegate` delegate
    func loadData(refresh: Bool = false) {
        guard couldLoadMore else { return }
        self.isRefreshing = refresh
        if self.isRefreshing {
            self.page = 1
            self.dataSource = []
        }
        if !self.isLoading  {
            self.isLoading = true
            self.delegate?.loadMore(self.page, onSuccess: { data in
                self.couldLoadMore = data.count != 0
                self.page += 1
                let startindex = self.dataSource.count
                self.dataSource = self.dataSource + data
                let endIndex = self.dataSource.count
                let indexPaths = (startindex..<endIndex).map{ IndexPath(row: $0, section: 0) }
                self.isLoading = false
                self.delegate?.reload(indexPaths: indexPaths)
            }, onError: { error in
                self.isLoading = false
            })

        }
    }
}
