//
//  Observable.swift
//  GithubPRs
//
//  Created by Amandeep on 14/01/23.
//

import Foundation

public class Observable<T> {
    public typealias Listener = (T) -> Void
    private var listener: Listener?
    
    public var value: T {
        didSet {
            self.listener?(self.value)
        }
    }
    
   public init(_ value: T) {
        self.value = value
    }
    
   public func bind(listener: Listener?) {
        self.listener = listener
        listener?(value)
    }
}
