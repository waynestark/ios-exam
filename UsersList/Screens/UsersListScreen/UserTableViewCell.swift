//
//  UserTableViewCell.swift
//  UsersList
//
//  Created by Marc Jardine Esperas on 11/17/22.
//

import UIKit

class UserTableViewCell: UITableViewCell {
    // MARK: UI Declaration
    private let thumbnailImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        imageView.layer.cornerRadius = 36
        imageView.addBorder()
        imageView.addShadow()
        imageView.clipsToBounds = true
        return imageView
    }()
    
    // Label Container (usernameLabel and fullnameLabel)
    private let labelContainerStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.layoutMargins = UIEdgeInsets(top: 12, left: 8, bottom: 12, right: 16)
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.distribution = .fillProportionally
        return stackView
    }()
    
    private let usernameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .textColor
        label.font = .preferredFont(forTextStyle: .title3)
        label.adjustsFontSizeToFitWidth = true
        label.numberOfLines = 1
        return label
    }()
    
    private let fullnameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .textColor
        label.font = .preferredFont(forTextStyle: .title3)
        label.adjustsFontSizeToFitWidth = true
        label.numberOfLines = 1
        return label
    }()
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        addComponents()
        layoutComponents()
    }
    
    // MARK: Components Builder
    private func addComponents() {
        contentView.addSubview(thumbnailImageView)
        contentView.addSubview(labelContainerStackView)
        labelContainerStackView.addArrangedSubview(usernameLabel)
        labelContainerStackView.addArrangedSubview(fullnameLabel)
    }
    
    private func layoutComponents() {
        NSLayoutConstraint.activate([
            thumbnailImageView.centerYAnchor.constraint(equalTo: centerYAnchor),
            thumbnailImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            thumbnailImageView.heightAnchor.constraint(equalToConstant: 72),
            thumbnailImageView.widthAnchor.constraint(equalToConstant: 72),

            labelContainerStackView.topAnchor.constraint(equalTo: topAnchor),
            labelContainerStackView.trailingAnchor.constraint(equalTo: trailingAnchor),
            labelContainerStackView.bottomAnchor.constraint(equalTo: bottomAnchor),
            labelContainerStackView.leadingAnchor.constraint(equalTo: thumbnailImageView.trailingAnchor)
        ])
    }
}

// MARK: External Method Call
extension UserTableViewCell {
    func setThumbnail(image: UIImage?) {
        thumbnailImageView.image = image
    }
    
    func setLabels(user: User) {
        usernameLabel.text = user.login.username
        fullnameLabel.text = "\(user.name.first) \(user.name.last)"
    }
}
