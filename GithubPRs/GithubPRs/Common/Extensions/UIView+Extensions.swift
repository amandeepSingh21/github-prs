//
//  UIView+Extensions.swift
//  GithubPRs
//
//  Created by Amandeep on 14/01/23.
//

import Foundation
import UIKit

extension UIView {
    func pin(to view: UIView,
             topEdge: CGFloat? = nil,
             bottomEdge: CGFloat? = nil,
             leadingEdge: CGFloat? = nil,
             trailingEdge: CGFloat? = nil,
             height: CGFloat? = nil,
             width: CGFloat? = nil,
             centerX: CGFloat? = nil,
             centerY: CGFloat? = nil)
    {
        translatesAutoresizingMaskIntoConstraints = false
        if let topEdge = topEdge {
            topAnchor.constraint(equalTo: view.topAnchor, constant: topEdge).isActive = true
        }
        if let leadingEdge = leadingEdge {
            leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: leadingEdge).isActive = true
        }
        if let trailingEdge = trailingEdge {
            view.trailingAnchor.constraint(equalTo: trailingAnchor, constant: trailingEdge).isActive = true
        }
        if let bottomEdge = bottomEdge {
            view.bottomAnchor.constraint(equalTo: bottomAnchor, constant: bottomEdge).isActive = true
        }
        if let height = height {
            heightAnchor.constraint(equalToConstant: height).isActive = true
        }
        if let width = width {
            widthAnchor.constraint(equalToConstant: width).isActive = true
        }
        if let centerX = centerX {
            centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: centerX).isActive = true
        }
        if let centerY = centerY {
            centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: centerY).isActive = true
        }
    }
}
