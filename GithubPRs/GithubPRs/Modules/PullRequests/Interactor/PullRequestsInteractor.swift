//
//  PullRequestInteractor.swift
//  GithubPRs
//
//  Created by Amandeep on 14/01/23.
//

import Foundation

protocol PullRequestInteractorProtocol {
    func load(_ request: Request, completion: @escaping PullRequestAPIResult)
    func cancelRequest()
}

typealias PullRequestAPIResult = (Result<[PullRequestViewModel], ErrorViewModel>) -> Void

final class PullRequestInteractor: PullRequestInteractorProtocol {
    private let networkManager: NetworkManager
    
    //MARK: Public
    init(networkManager: NetworkManager = NetworkManager.shared) {
        self.networkManager = networkManager
    }
    
    func load(_ request: Request, completion: @escaping PullRequestAPIResult) {
        printLog(request)
        self.networkManager.dataTask(request) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let data):
                do {
                    printLog(request)
                    let response = try decoder.decode([PullRequest].self, from: data)
                   let domain = response.map { $0.toDomain() }
                   completion(.success(domain))
                } catch {
                    completion(.failure(ErrorViewModel("Something went wrong!")))
                }
            case .failure(let error):
                self.handleFailure(error, completion: completion)
            }
        }
    }
    
    func cancelRequest() {
       // URLSession.shared.getAllTasks { tasks in
           // _ =  tasks.filter { $0.state == .running }.map { $0.cancel() }
       // }
    }
   
    //MARK: Private
    private func handleFailure(_ error: NetworkError, completion: @escaping PullRequestAPIResult) {
        if let data = error.apiError {
            do {
                let error = try decoder.decode(GHError.self, from: data)
                completion(.failure(ErrorViewModel(error.message)))
            } catch {
                completion(.failure(ErrorViewModel("Something went wrong!")))
            }
        } else {
            if let message  = error.urlSessionError.underlyingError?.localizedDescription {
                completion(.failure(.init(message)))
            } else {
                completion(.failure(.init(error.urlSessionError.message)))
            }
            
        }
    }
   
}
