//
//  NetworkManager.swift
//  GithubPRs
//
//  Created by Amandeep on 14/01/23.
//

//Mock: Error
//Mock: Data, 200
//Mock: Data, non 200
//Mock: No Data, non 200
//Mock: Data, non 200 rate limit

import Foundation
import Network

final class NetworkManager {
    // MARK: Typealias
    typealias CompletionResult = (Result<Data, NetworkError>) -> Void
    
    // MARK: - Shared Instance
    static let shared = NetworkManager(session: URLSession.shared, reachability: Reachability.shared)
    
    //MARK: - Private Properties
    private let session: URLSessionProtocol
    private var task: URLSessionDataTaskProtocol?
    private let reachability: ReachabilityProtocol
    
    // MARK: - Initialiser
    init(session: URLSessionProtocol, reachability: ReachabilityProtocol) {
        self.session = session
        self.reachability = reachability
        self.reachability.startMonitoring()
    }
    
    // MARK: - Data Task Helper
    ///Takes request, returns raw data or formatted error
    ///>  Note: The decision to not parse `APIResponse` or `APIError` is a consious one.
    ///Although it can be very easily done using generics, we don't want to couple Serialization with networking client
    ///For eg. Data could be HTTP response or XML OR some clients may want to use a faster lib for Serilziation
    /// - Parameters:
    ///   - request: A description of HTTP request
    ///   - completion: Returns Data on success or NetworkError on failure
    ///     - `Data`: Raw HTTP Response
    ///     - `NetworkError`: Divided into two parts: Generic network error and domain specific API error
    ///       - `apiError`: Optional. This is domain specfic API error. Clients should parse this as first priority.
    ///        - `genericError`:
    ///         - `message`: A fallback/generic error string. Last priority
    ///         - `underlyingError`: Optional. Maps to URLSession NSError. Parse this object after apiError as second priority 
    ///         - `statusCode`: Optional. Maps to HTTPURLResponse status code.
    func dataTask(_ request: Request, completion: @escaping CompletionResult) {
       
        
        guard reachability.isConnectedToNetwork() else {
            completion(.failure(.init(.init("Internet is not connected"))))
            return
        }
        task = session.dataTask(with: urlRequest(for: request)) { [weak self] (data, response, error) in
            guard let self = self else { return }
            if let error = error {
                if error.code == NetworkingConstants.RequestCancellationError {
                    return
                }
                let error = HTTPError(error.localizedDescription, underlyingError: error as NSError, httpURLResponse: response?.httpURLResponse)
                self.completionResult(.failure(NetworkError(error)), completionResult: completion)
                return
            }

            if let response = response, response.isSuccess {
                if let data = data {
                    self.completionResult(.success(data), completionResult: completion)
                }
            } else {
                let commonErrorMessage = NSLocalizedString("Something went wrong!", comment: "")
                guard let data = data else {
                    let error = HTTPError(commonErrorMessage,httpURLResponse: response?.httpURLResponse)
                    self.completionResult(.failure(NetworkError(error)), completionResult: completion)
                    return
                }
                var error = HTTPError(commonErrorMessage)
                if let message = self.errorForRateLimit(response?.httpURLResponse) {
                    error = HTTPError(message)
                    self.completionResult(.failure(NetworkError(error, apiError: nil)), completionResult: completion)
                    return
                }
                self.completionResult(.failure(NetworkError(error, apiError: data)), completionResult: completion)
                
            }
        }
        self.task?.resume()
    }
    
    func cancel() {
        self.task?.cancel()
    }
    
    //MARK: - Private Helper Functions
    private func completionResult(_ result: Result<Data, NetworkError>, completionResult: @escaping CompletionResult) {
        DispatchQueue.main.async {
            completionResult(result)
        }
    }
    
    private func urlRequest(for request: Request) -> URLRequest {
        let url = URL(NetworkingConstants.host, request)
        var result = URLRequest(url: url)
        result.httpMethod = request.method.rawValue
       // result.cachePolicy = .reloadIgnoringLocalAndRemoteCacheData
        printLog(url)
        return result
    }
    
    private func errorForRateLimit(_ urlResponse: HTTPURLResponse?) -> String? {
        guard let urlResponse  = urlResponse else { return nil }
        guard let remainingLimit = urlResponse.value(forHTTPHeaderField: "X-RateLimit-Remaining") else { return nil }
        guard let limit = Int(remainingLimit), limit == 0 else { return nil }
        guard let resetTime = urlResponse.value(forHTTPHeaderField: "X-RateLimit-Reset") else { return nil }
        guard let resetTimeInDouble = Double(resetTime) else { return nil }
       
        let startDate = Date()
        let endDate = Date(timeIntervalSince1970: resetTimeInDouble)
        let diffSeconds = Int(endDate.timeIntervalSince1970 - startDate.timeIntervalSince1970)
        let minutes = diffSeconds / 60
        return "Rate limited: Please try again in: \(minutes) minutes"
    }

}
