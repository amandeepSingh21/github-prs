//
//  StatusView.swift
//  GithubPRs
//
//  Created by Amandeep on 14/01/23.
//

import Foundation
import UIKit

class MessageView: NiblessView {
    
    // MARK: - Properties
    var message: String {
        didSet { self.messageLabel.text = message }
    }
    
    ///Used to show view model state
    private let messageLabel : UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.textColor = .label
        lbl.textAlignment = .center
        return lbl
    }()
    
    // MARK: - Methods
    init(message: String, frame: CGRect = .zero) {
        self.message = message
        super.init(frame: frame)
        self.backgroundColor = .systemBackground
        addSubview(messageLabel)
        messageLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        messageLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
    }
}
