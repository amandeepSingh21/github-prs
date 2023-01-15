//
//  PullRequestCell.swift
//  GithubPRs
//
//  Created by Amandeep on 14/01/23.
//

import Foundation
import UIKit

class PullRequestCell : UITableViewCell {
    //MARK: - Properties
    static let identifier = "PullRequestCell"
    
    ///Render cell with data
    var pullRequest : PullRequestViewModel? {
        didSet {
            guard let pullRequest = pullRequest else { return }
            self.loginSpinner.startAnimating()
            photoImageView.loadImage(at: pullRequest.user.avatarURL) { [weak self] in
                self?.loginSpinner.stopAnimating()
            }
            
            titleLabel.text = pullRequest.title
            descriptionLabel.text = pullRequest.body
            captionLabel.text = pullRequest.caption
            self.photoImageView.makeCircular()
        }
    }
    
    ///Image loader
    let loginSpinner: UIActivityIndicatorView = {
        let loginSpinner = UIActivityIndicatorView(style: .medium)
        loginSpinner.translatesAutoresizingMaskIntoConstraints = false
        loginSpinner.hidesWhenStopped = true
        return loginSpinner
    }()
    
    
    private let verticalStack : UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .horizontal
        stack.alignment = .top
        //stack.distribution = .fill
        stack.spacing = 16
        return stack
    }()
    
    ///Used to apply layout marging (left, right) padding to title, description and caption
    private let nestedVerticalStack: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.alignment = .fill
        stack.distribution = .fill
        stack.spacing = 8
        stack.isLayoutMarginsRelativeArrangement = true
        stack.directionalLayoutMargins = NSDirectionalEdgeInsets(top: 0, leading: 16, bottom: 0, trailing: 16)
        return stack
    }()
    
    private let titleLabel: UILabel = {
        let lbl = UILabel()
        lbl.textColor = .label
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.font = UIFont.preferredFont(forTextStyle: UIFont.TextStyle.headline)
        lbl.setContentHuggingPriority(.required, for: .vertical)
        lbl.numberOfLines = 1
        return lbl
    }()
    
    private let descriptionLabel: UILabel = {
        let lbl = UILabel()
        lbl.textColor = .label
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.font = UIFont.preferredFont(forTextStyle: UIFont.TextStyle.subheadline)
        lbl.setContentHuggingPriority(.defaultHigh, for: .vertical)
        lbl.numberOfLines = 3
        return lbl
    }()
    
    private let captionLabel: UILabel = {
        let lbl = UILabel()
        lbl.textColor = .secondaryLabel
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.font = UIFont.preferredFont(forTextStyle: UIFont.TextStyle.caption1)
        lbl.numberOfLines = 2
        return lbl
    }()
    
    private let photoImageView : UIImageView = {
        let imgView = UIImageView(image: UIImage(named: "placeholder"))
        imgView.translatesAutoresizingMaskIntoConstraints = false
        imgView.contentMode = .scaleAspectFill
       
        imgView.backgroundColor = UIColor.gray.withAlphaComponent(0.3)
        return imgView
    }()
    
    //MARK: - Methods
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.contentView.backgroundColor = .systemBackground
        setupConstraints()
    }
    
    private func setupConstraints() {
        self.contentView.addSubview(verticalStack)
        verticalStack.pin(to: contentView,topEdge: 16, bottomEdge: 16, leadingEdge: 16,trailingEdge: 16)
        ///Spinner
        self.photoImageView.addSubview(loginSpinner)
        loginSpinner.centerXAnchor.constraint(equalTo: photoImageView.centerXAnchor).isActive = true
        loginSpinner.centerYAnchor.constraint(equalTo: photoImageView.centerYAnchor).isActive = true
        photoImageView.widthAnchor.constraint(equalToConstant: 60).isActive = true
        photoImageView.heightAnchor.constraint(equalToConstant: 60).isActive = true
        ///Add views to stack
        verticalStack.addArrangedSubview(photoImageView)
        ///Add title, desc and caption to inner stackveiw for left and right padding
        nestedVerticalStack.addArrangedSubview(titleLabel)
        nestedVerticalStack.addArrangedSubview(descriptionLabel)
        nestedVerticalStack.setCustomSpacing(16, after: descriptionLabel)
        nestedVerticalStack.addArrangedSubview(captionLabel)
        verticalStack.addArrangedSubview(nestedVerticalStack)
        self.photoImageView.makeCircular()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    ///Supports image download cancelling as well
    override func prepareForReuse() {
        photoImageView.image = nil
        photoImageView.cancelImageLoad()
        loginSpinner.stopAnimating()
    }
}
