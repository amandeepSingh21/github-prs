//
//  PRCommentsController.swift
//  GithubPRs
//
//  Created by Amandeep on 15/01/23.
//

import Foundation

class PRCommentsController: NiblessViewController {
    
    //MARK: - Child View Controller
    let messageController: MessageController
    
    //MARK: - Properties
    var rootView: PRCommentsView
    let presenter: PRCommentsPresenterProtocol
    
    //MARK: - Methods
    init(presenter: PRCommentsPresenterProtocol) {
        self.presenter = presenter
        self.messageController = MessageController(message: presenter.viewState.value.message)
        rootView = PRCommentsView(presenter: self.presenter, frame: .zero)
        super.init()
    }
    
    override func loadView() {
        self.view = rootView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setUpBindings()
        navigationController?.navigationBar.prefersLargeTitles = true
        self.tabBarController?.tabBar.isHidden = true
        self.presenter.load()
        
    }
    
    ///Used to switch b/w table view and status messages
    private func setUpBindings() {
        self.presenter.viewState.bind { [weak self] state in
            guard let self = self else { return }
            self.messageController.message = state.message
            switch state {
            case .notLoaded,.noResultsFound,.loading(_):
                self.addFullScreen(childViewController: self.messageController)
            case .error(let message):
                self.remove(childViewController: self.messageController)
                self.present(errorMessage: message)
            case .loaded:
                self.remove(childViewController: self.messageController)
                
            }
        }
    }
    

}
