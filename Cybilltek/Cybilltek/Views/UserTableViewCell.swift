//
//  UserTableViewCell.swift
//  Cybilltek
//
//  Created by Jervy Umandap on 5/8/24.
//

import UIKit
import Kingfisher

class UserTableViewCell: UITableViewCell {
    static let identifier = "UserTableViewCell"
    
    var user: User?
    
    public let userImageContainer: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 5.0
        view.clipsToBounds = true
        view.layer.masksToBounds = true
        view.backgroundColor = .secondarySystemBackground
        return view
    }()
    
    private let userImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.masksToBounds = true
        imageView.layer.cornerRadius = 0
        return imageView
    }()
    
    private let userInformationContainer: UIView = {
        let view = UIView()
        return view
    }()
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 20, weight: .bold)
        label.numberOfLines = 0
        label.layer.masksToBounds = true
        return label
    }()
    
    private let emailLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 15, weight: .medium)
        label.numberOfLines = 0
        label.layer.masksToBounds = true
        return label
    }()
    
    private let countryLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 15, weight: .medium)
        label.numberOfLines = 0
        label.layer.masksToBounds = true
        return label
    }()
    
    private let phoneLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 15, weight: .medium)
        label.numberOfLines = 0
        label.layer.masksToBounds = true
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(userImageContainer)
        userImageContainer.addSubview(userImageView)
        contentView.addSubview(userInformationContainer)
        
        userInformationContainer.addSubview(nameLabel)
        userInformationContainer.addSubview(emailLabel)
        userInformationContainer.addSubview(countryLabel)
        userInformationContainer.addSubview(phoneLabel)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        let userImageContainerWidth = CGFloat(100)
        let userInformationLabelHeight = userInformationContainer.height / 4
        userImageContainer.frame = CGRect(
            x: 10,
            y: 5,
            width: userImageContainerWidth,
            height: contentView.height - 10)
        
        userImageView.frame = userImageContainer.bounds
        
        userInformationContainer.frame = CGRect(
            x: userImageContainer.right + 10,
            y: 5,
            width: (contentView.width - userImageContainerWidth) - 30,
            height: contentView.height - 10)
        
//        userInformationContainer.backgroundColor = .systemGreen
//        nameLabel.backgroundColor = .systemBlue
//        emailLabel.backgroundColor = .systemRed
//        countryLabel.backgroundColor = .systemBlue
//        phoneLabel.backgroundColor = .systemRed
        
        nameLabel.frame = CGRect(
            x: 0,
            y: 0,
            width: userInformationContainer.width,
            height: userInformationLabelHeight)
        
        emailLabel.frame = CGRect(
            x: 0,
            y: nameLabel.bottom,
            width: userInformationContainer.width,
            height: userInformationLabelHeight)
        phoneLabel.frame = CGRect(
            x: 0,
            y: emailLabel.bottom,
            width: userInformationContainer.width,
            height: userInformationLabelHeight)
        countryLabel.frame = CGRect(
            x: 0,
            y: phoneLabel.bottom,
            width: userInformationContainer.width,
            height: userInformationLabelHeight)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        userImageView.image = nil
        nameLabel.text = nil
        countryLabel.text = nil
        emailLabel.text = nil
        phoneLabel.text = nil
    }
    
    func configure(withViewModel model: UserTableViewCellViewModel) {
        userImageView.kf.setImage(with: model.imageURL)
        nameLabel.text = model.name
        countryLabel.text = model.country
        emailLabel.text = model.email
        phoneLabel.text = model.phone
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
