//
//  ImageLoader.swift
//  GithubPRs
//
//  Created by Amandeep on 14/01/23.
//

import Foundation
import UIKit

class ImageLoader {
  private var loadedImages = [URL: UIImage]()
  private var runningRequests = [UUID: URLSessionDataTaskProtocol]()
    
private let session: URLSessionProtocol
    // MARK: - Initialiser
    init(session: URLSessionProtocol = URLSession.shared) {
        self.session = session
    }
    
    func loadImage(_ url: URL, _ completion: @escaping (Result<UIImage, Error>) -> Void) -> UUID? {

      if let image = loadedImages[url] {
        completion(.success(image))
        return nil
      }

      let uuid = UUID()

        let task = self.session.dataTask(with: URLRequest(url: url)) { data, response, error in
        defer {self.runningRequests.removeValue(forKey: uuid) }

        if let data = data, let image = UIImage(data: data) {
          self.loadedImages[url] = image
          completion(.success(image))
          return
        }


          guard let error = error else {
              return
          }

        guard (error as NSError).code == NSURLErrorCancelled else {
          completion(.failure(error))
          return
        }
          
      }
      task.resume()

      runningRequests[uuid] = task
      return uuid
    }
    
    func cancelLoad(_ uuid: UUID) {
      runningRequests[uuid]?.cancel()
      runningRequests.removeValue(forKey: uuid)
    }
}

