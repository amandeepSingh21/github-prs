//
//  PRCommitsInteractor.swift
//  GithubPRs
//
//  Created by Amandeep on 15/01/23.
//

import Foundation

protocol PRCommitsInteractorProtocol {
    func load(_ request: Request, completion: @escaping PRCommitAPIResult)
    func cancelRequest()
}

typealias PRCommitAPIResult = (Result<[PRCommitViewModel], ErrorViewModel>) -> Void

final class PRCommitsInteractor: PRCommitsInteractorProtocol {
    private let networkManager: NetworkManager
    
    //MARK: Public
    init(networkManager: NetworkManager = NetworkManager.shared) {
        self.networkManager = networkManager
    }
    
    func load(_ request: Request, completion: @escaping PRCommitAPIResult) {
        self.networkManager.dataTask(request) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let data):
                do {
                    printLog(request)
                    let response = try decoder.decode([PRCommit].self, from: data)
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
    private func handleFailure(_ networkError: NetworkError, completion: @escaping PRCommitAPIResult) {
        if let data = networkError.apiError {
            do {
                let error = try decoder.decode(GHError.self, from: data)
                completion(.failure(ErrorViewModel(error.message, networkError: networkError)))
            } catch {
                completion(.failure(ErrorViewModel("Something went wrong!", networkError: networkError)))
            }
        } else {
            if let message  = networkError.urlSessionError.underlyingError?.localizedDescription {
                completion(.failure(.init(message, networkError: networkError)))
            } else {
                completion(.failure(.init(networkError.urlSessionError.message, networkError: networkError)))
            }
            
        }
    }
   
}
