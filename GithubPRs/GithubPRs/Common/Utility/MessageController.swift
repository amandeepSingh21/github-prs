//
//  StatusViewController.swift
//  GithubPRs
//
//  Created by Amandeep on 14/01/23.
//

import Foundation

class MessageController: NiblessViewController {
    
    private var rootView: MessageView
    
    var message: String {
        didSet {
            self.rootView.message = message
        }
    }
    
    init(message:String) {
        self.message = message
        self.rootView = MessageView(message: message, frame: .zero)
        super.init()
    }
    
    override func loadView() {
        self.view = rootView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
