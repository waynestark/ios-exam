//
//  DetailsViewController.swift
//  RandomUsers
//
//  Created by jmmanoza on 6/6/24.
//

import Foundation
import UIKit

class DetailsViewController: UIViewController {
    
    var person: Person?
    
    let avatarImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let birthdayLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let ageLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let emailLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let genderLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let mobileNoLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let addressLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        displayPersonDetails()
    }

    private func setupUI() {

        view.backgroundColor = .white
        title = "Details"
        
        view.addSubview(avatarImageView)
        view.addSubview(nameLabel)
        view.addSubview(birthdayLabel)
        view.addSubview(ageLabel)
        view.addSubview(emailLabel)
        view.addSubview(genderLabel)
        view.addSubview(mobileNoLabel)
        view.addSubview(addressLabel)
        
        // Set up constraints
        NSLayoutConstraint.activate([
            avatarImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            avatarImageView.topAnchor.constraint(equalTo: view.topAnchor, constant: 100),
            avatarImageView.widthAnchor.constraint(equalToConstant: view.bounds.size.width),
            avatarImageView.heightAnchor.constraint(equalToConstant: 300),
            
            nameLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            nameLabel.topAnchor.constraint(equalTo: avatarImageView.bottomAnchor, constant: 20),
            
            birthdayLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            birthdayLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 20),
            
            ageLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            ageLabel.topAnchor.constraint(equalTo: birthdayLabel.bottomAnchor, constant: 20),
            
            emailLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            emailLabel.topAnchor.constraint(equalTo: ageLabel.bottomAnchor, constant: 20),
            
            genderLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            genderLabel.topAnchor.constraint(equalTo: emailLabel.bottomAnchor, constant: 20),
            
            mobileNoLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            mobileNoLabel.topAnchor.constraint(equalTo: genderLabel.bottomAnchor, constant: 20),
            
            addressLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            addressLabel.topAnchor.constraint(equalTo: mobileNoLabel.bottomAnchor, constant: 20),
        ])
    }

    private func displayPersonDetails() {
        guard let person = person else { return }

        if let url = URL(string: person.picture?.large ?? "") {
            avatarImageView.sd_setImage(with: url)
        }
 
        nameLabel.text = "\(person.name?.first ?? "") \(person.name?.last ?? "")"
        birthdayLabel.text = "Birthday: \(formatDate(dateString: person.registered?.date ?? ""))"
        ageLabel.text = "Age: \(person.registered?.age ?? 0)"
        emailLabel.text = "Email Address: \(person.email)"
        genderLabel.text = "Gender: \(person.gender.capitalized)"
        mobileNoLabel.text = "Mobile No.: \(person.cell)"

        if let location = person.location, let street = person.location?.street {
            let address = "\(street.name) \(street.number) \(location.state) \(location.country)"
            addressLabel.text = "Address: \(address)"
        }
    }
    
    private func formatDate(dateString: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"

        if let date = dateFormatter.date(from: dateString) {
            dateFormatter.dateFormat = "MMM d, yyyy 'at' h:mm:ss a"
            let formattedDateString = dateFormatter.string(from: date)
            return formattedDateString
        } else {
            print("Invalid date string")
            return ""
        }
    }
}
