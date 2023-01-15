//
//  UIImageLoader.swift
//  GithubPRs
//
//  Created by Amandeep on 14/01/23.
//

import Foundation
import UIKit

class UIImageLoader {
  static let loader = UIImageLoader()

  private let imageLoader = ImageLoader()
  private var uuidMap = [UIImageView: UUID]()

  private init() {}

    func load(_ url: URL, for imageView: UIImageView, completion: (() -> Void)? = nil) {
      let token = imageLoader.loadImage(url) { result in
        defer { self.uuidMap.removeValue(forKey: imageView) }
          DispatchQueue.main.async {
              do {
                  let image = try result.get()
                  imageView.image = image
                  completion?()
                  
              } catch {
                  completion?()
              }
          }
      }

      if let token = token {
        uuidMap[imageView] = token
      }
    }
    
    func cancel(for imageView: UIImageView) {
      if let uuid = uuidMap[imageView] {
        imageLoader.cancelLoad(uuid)
        uuidMap.removeValue(forKey: imageView)
      }
    }
}

extension UIImageView {
    func loadImage(at url: URL, completion: (() -> Void)? = nil) {
    UIImageLoader.loader.load(url, for: self, completion: completion)
  }

  func cancelImageLoad() {
    UIImageLoader.loader.cancel(for: self)
  }
    
    func makeCircular() {
        let radius = 60/2.0
        self.layer.cornerRadius = radius
        self.layer.masksToBounds = true
    }
}
