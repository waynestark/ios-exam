//
//  UserCell.swift
//  RandomUsers
//
//  Created by jmmanoza on 6/6/24.
//

import Foundation
import SDWebImage
import UIKit

//class UserCell: UITableViewCell {
//    static let identifier = "Usercell"
//    
//    let avatarImage = UIImageView()
//    private let nameLabel: UILabel = {
//        let label = UILabel()
//        label.font = .systemFont(ofSize: 17, weight: .bold)
//        return label
//    }()
//    
//    private let emailLabel: UILabel = {
//        let label = UILabel()
//        return label
//    }()
//    
//    private let locationLabel: UILabel = {
//        let label = UILabel()
//        label.numberOfLines = 1
//        return label
//    }()
//    
//    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
//        super.init(style: style, reuseIdentifier: reuseIdentifier)
//        addSubview(avatarImage)
//        addSubview(nameLabel)
//        addSubview(emailLabel)
//        addSubview(locationLabel)
//        
//        avatarImage.frame = CGRect(x: 10, y: 10, width: 100, height: 100)
//        nameLabel.frame = CGRect(x: 120, y: 20, width: 1000, height: 30)
//        emailLabel.frame = CGRect(x: 120, y: 50, width: 1000, height: 30)
//        locationLabel.frame = CGRect(x: 120, y: 80, width: 1000, height: 30)
//        avatarImage.clipsToBounds = true
//    }
//    
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//    
//    func configCell(user: Person) {
//        nameLabel.text = "\(user.name?.first ?? "") \(user.name?.last ?? "")"
//        emailLabel.text = user.email
//        locationLabel.text = "\(user.location?.city ?? "") \(user.location?.state ?? "") \(user.location?.country ?? "")"
//        avatarImage.layer.cornerRadius = 50
//        avatarImage.sd_setImage(with: URL(string: user.picture?.large ?? ""))
//    }
//}


import UIKit

class UserCell: UITableViewCell {
    
    static let identifier = "Usercell"
    
    let profileImageView = UIImageView()
    let nameLabel = UILabel()
    let emailLabel = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupUI()
    }
    
    private func setupUI() {
        // Add the subviews
        contentView.addSubview(profileImageView)
        contentView.addSubview(nameLabel)
        contentView.addSubview(emailLabel)
        
        // Set translatesAutoresizingMaskIntoConstraints to false
        profileImageView.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        emailLabel.translatesAutoresizingMaskIntoConstraints = false
        
        // Configure the UI elements
        profileImageView.layer.cornerRadius = 25 // Assuming a circular image
        profileImageView.clipsToBounds = true
        profileImageView.contentMode = .scaleAspectFill
        
        nameLabel.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        emailLabel.font = UIFont.systemFont(ofSize: 14)
        emailLabel.textColor = .gray
        
        // Add constraints
        NSLayoutConstraint.activate([
            // Profile Image
            profileImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            profileImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            profileImageView.widthAnchor.constraint(equalToConstant: 50),
            profileImageView.heightAnchor.constraint(equalToConstant: 50),
            
            // Name Label
            nameLabel.leadingAnchor.constraint(equalTo: profileImageView.trailingAnchor, constant: 16),
            nameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            nameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
            
            // Email Label
            emailLabel.leadingAnchor.constraint(equalTo: profileImageView.trailingAnchor, constant: 16),
            emailLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            emailLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 8),
            emailLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16)
        ])
    }
    
    func configure(with user: Person) {
        nameLabel.text = "\(user.name?.first ?? "") \(user.name?.last ?? "")"
        emailLabel.text = user.email
        
        if let imageUrl = URL(string: user.picture?.medium ?? "") {
            profileImageView.sd_setImage(with: imageUrl, completed: nil)
        }
    }
}
