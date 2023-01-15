//
//  MockPRContainerWireframe.swift
//  GithubPRsTests
//
//  Created by Amandeep on 15/01/23.
//

import Foundation
import UIKit
@testable import GithubPRs

final class MockPRContainerWireframe: TabBarInterface {
    private let wireFrames: [PRWireframeInterface]
    private let title: String
    private let screenTypes: [ScreenType]

    //MARK: - Public methods
    init(_ wireFrames: PRWireframeInterface..., screenTypes: [ScreenType], title: String) {
        self.wireFrames = wireFrames
        self.title = title
        self.screenTypes = screenTypes
    }
    
    func configuredViewController() -> UIViewController {
      _ = wireFrames.map({ $0.buildView() })
        return UIViewController()
    }
}
