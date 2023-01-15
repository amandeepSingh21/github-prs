//
//  PullRequestView.swift
//  GithubPRs
//
//  Created by Amandeep on 14/01/23.
//

import Foundation
import UIKit

class PullRequestView: NiblessView {
    
    // MARK: - Properties
    private let presenter: PullRequestPresenterProtocol
    private let refreshControl = UIRefreshControl()
    
    private let tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.register(PullRequestCell.self, forCellReuseIdentifier: PullRequestCell.identifier)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.insetsContentViewsToSafeArea = true
        tableView.contentInsetAdjustmentBehavior = .automatic
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 600
        return tableView
    }()
    
    // MARK:- Init
    init(presenter: PullRequestPresenterProtocol, frame: CGRect = .zero) {
        self.presenter = presenter
        super.init(frame: frame)
        addViews()
        addConstriants()
        tableView.dataSource = self
        tableView.delegate = self
        addRefreshControl()
        self.bind()
    }
    
    //MARK:- Private Methods
    private func addConstriants() {
        tableView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        tableView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
    }
    
    private func addViews() {
       addSubview(tableView)
    }
    
    private func bind() {
        presenter.resetScrollViewOffset.bind(listener: { [weak self] (shouldReset) in
            if shouldReset {
                self?.tableView.setContentOffset(.zero, animated: false)
            }
        })
        
        presenter.indexPathsToReload.bind(listener: { [weak self] (indexPaths) in
            
            guard let self = self, let indexPaths = indexPaths else { return }
            self.refreshControl.endRefreshing()
            if self.isFirstPage() {
                self.tableView.reloadData()
            } else {
                self.tableView.insertRows(at: indexPaths, with: .automatic)
            }
        })
    }
    
    private func addRefreshControl() {
        refreshControl.addTarget(self, action: #selector(refreshData), for: .valueChanged)
        tableView.addSubview(refreshControl)
    }
    
    @objc private func refreshData(refreshControl: UIRefreshControl) {
        refreshControl.beginRefreshing()
        self.presenter.refresh()
    }
    
    private func isLoadingCell(for indexPath: IndexPath) -> Bool {
        return (indexPath.row >= presenter.pullRequests.count-1)
    }
    
    private func isFirstPage() -> Bool {
        if self.presenter.page < 3 { return true }
        else { return false }
    }
}

//MARK: - Datasource
extension PullRequestView: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return  presenter.pullRequests.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: PullRequestCell.identifier) as! PullRequestCell
        if let pullRequest = presenter.pullRequests[safe:indexPath.row] {
            cell.pullRequest = pullRequest
            return cell
        } else {
            return UITableViewCell()
        }
    }
}

//MARK:- TableView Delegate
extension PullRequestView: UITableViewDelegate {
    ///Toggle pagination loader
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if isLoadingCell(for: indexPath) {
            let spinner = UIActivityIndicatorView(style: .medium)
            spinner.startAnimating()
            spinner.frame = CGRect(x: CGFloat(0), y: CGFloat(0), width: tableView.bounds.width, height: CGFloat(44))
            
            self.tableView.tableFooterView = spinner
            self.tableView.tableFooterView?.isHidden = false
            self.presenter.loadMore()
        } else {
            self.tableView.tableFooterView?.isHidden = true
        }
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let pullRequests = self.presenter.pullRequests[safe: indexPath.row] {
            self.presenter.didSelect(pullRequest: pullRequests)
        }
    }
}
