//
//  UIViewControler+Extension.swift
//  GithubPRs
//
//  Created by Amandeep on 14/01/23.
//

import Foundation
import UIKit

extension UIViewController {
    
    // MARK: - Methods
    func present(errorMessage: ErrorViewModel) {
        let errorAlertController = UIAlertController(title: errorMessage.message,
                                                     message: "",
                                                     preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default)
        errorAlertController.addAction(okAction)
        present(errorAlertController, animated: true, completion: nil)
    }
    
}
