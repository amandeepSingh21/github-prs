//
//  PullRequestsContainer.swift
//  GithubPRs
//
//  Created by Amandeep on 15/01/23.
//

import Foundation
import UIKit

protocol ScreenType {
    var displayValue: String { get }
}

/// Reuseable tabar wrapper around UISegmentedControl used to render child view controllers
final class SegmentedViewController: NiblessViewController {
    
    //MARK: - Private props
    private let screenTypes: [ScreenType]
    private let segmentedControl: UISegmentedControl
    
    private let VStack: UIStackView = {
        let VStack = UIStackView()
        VStack.axis = .vertical
        VStack.spacing = 16
        VStack.translatesAutoresizingMaskIntoConstraints = false
        return VStack
    }()
    
    //MARK: - Public props
    /// Array of child view controllers to render
    var viewControllers: [UIViewController] = []
    
    //MARK: - Public Methods
    /// Creates a Segmented Container View Controller
    /// - Parameters:
    ///   - screenTypes: Used to configure display text of UISemengtedControl
    ///   - title: navation bar title
    init(screenTypes: [ScreenType], title: String) {
        self.screenTypes = screenTypes
        segmentedControl = UISegmentedControl(items: self.screenTypes.map( {$0.displayValue }))
        super.init()
        self.title = title
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        view.addSubview(VStack)
        VStack.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        VStack.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        VStack.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        VStack.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        segmentedControl.selectedSegmentIndex = 0
        segmentedControl.addTarget(self, action: #selector(handleSegmentChange), for: .valueChanged)
        VStack.addArrangedSubview(segmentedControl)
        updateUI()
    }
    
    //MARK: - Private Methods
    private func updateUI() {
        for (index,childViewController) in self.viewControllers.enumerated() {
            addChild(childViewController)
            self.VStack.addArrangedSubview(childViewController.view)
            childViewController.didMove(toParent: self)
            childViewController.view.isHidden = index != segmentedControl.selectedSegmentIndex
        }
    }
    
    @objc private func handleSegmentChange() {
        for (index,childViewController) in self.viewControllers.enumerated() {
            childViewController.view.isHidden = index != segmentedControl.selectedSegmentIndex
        }
    }
}
