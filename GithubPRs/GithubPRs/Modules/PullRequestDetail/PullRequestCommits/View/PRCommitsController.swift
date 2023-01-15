//
//  PRCommitsController.swift
//  GithubPRs
//
//  Created by Amandeep on 15/01/23.
//

import Foundation

final class PRCommitsController: NiblessViewController {
    
    //MARK: - Child View Controller
    private let messageController: MessageController
    
    //MARK: - Properties
    private var rootView: PRCommitsView
    private let presenter: PRCommitsPresenterProtocol
    
    //MARK: - Methods
    init(presenter: PRCommitsPresenterProtocol) {
        self.presenter = presenter
        self.messageController = MessageController(message: presenter.viewState.value.message)
        rootView = PRCommitsView(presenter: self.presenter, frame: .zero)
        super.init()
    }
    
    override func loadView() {
        self.view = rootView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setUpBindings()
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
