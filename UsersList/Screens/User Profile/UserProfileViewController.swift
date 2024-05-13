//
//  UserProfileViewController.swift
//  UsersList
//
//  Created by Marc Jardine Esperas on 11/16/22.
//

import UIKit

class UserProfileViewController: UIViewController {
    // MARK: UI Declaration
    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    private let containerStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.layoutMargins = UIEdgeInsets(top: 16, left: 0, bottom: 0, right: 0)
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.distribution = .fill
        return stackView
    }()
    
    private let profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private let descriptionStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 12
        stackView.layoutMargins = UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.distribution = .fill
        return stackView
    }()
    
    private let firstnameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .textColor
        label.font = .preferredFont(forTextStyle: .title3)
        label.numberOfLines = 0
        label.sizeToFit()
        return label
    }()
    
    private let lastnameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .textColor
        label.font = .preferredFont(forTextStyle: .title3)
        label.numberOfLines = 0
        label.sizeToFit()
        return label
    }()
    
    private let birthdayLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .textColor
        label.font = .preferredFont(forTextStyle: .title3)
        label.numberOfLines = 0
        label.sizeToFit()
        return label
    }()
    
    private let ageLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .textColor
        label.font = .preferredFont(forTextStyle: .title3)
        label.numberOfLines = 0
        label.sizeToFit()
        return label
    }()
    
    private let emailLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .textColor
        label.font = .preferredFont(forTextStyle: .title3)
        label.numberOfLines = 0
        label.sizeToFit()
        return label
    }()
    
    private let mobileLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .textColor
        label.font = .preferredFont(forTextStyle: .title3)
        label.numberOfLines = 0
        label.sizeToFit()
        return label
    }()
    
    private let addressLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .textColor
        label.font = .preferredFont(forTextStyle: .title3)
        label.numberOfLines = 0
        label.sizeToFit()
        return label
    }()
    
    var viewModel: UserProfileViewModelProtocol
    
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    
    init(viewModel: UserProfileViewModelProtocol) {
        self.viewModel = viewModel
        
        super.init(nibName: nil, bundle: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "User Profile"
        
        addComponents()
        layoutComponents()
        
        setupDetails()
    }
    
    override func loadView() {
        view = UIView()
        view.backgroundColor = .white
    }
    
    // MARK: Components Builder
    private func addComponents() {
        view.addSubview(scrollView)
        scrollView.addSubview(containerStackView)
        containerStackView.addArrangedSubview(profileImageView)
        containerStackView.addArrangedSubview(descriptionStackView)
        descriptionStackView.addArrangedSubview(firstnameLabel)
        descriptionStackView.addArrangedSubview(lastnameLabel)
        descriptionStackView.addArrangedSubview(birthdayLabel)
        descriptionStackView.addArrangedSubview(ageLabel)
        descriptionStackView.addArrangedSubview(emailLabel)
        descriptionStackView.addArrangedSubview(mobileLabel)
        descriptionStackView.addArrangedSubview(addressLabel)
    }
    
    private func layoutComponents() {
        NSLayoutConstraint.activate([
            scrollView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            scrollView.widthAnchor.constraint(equalTo: view.widthAnchor),
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            containerStackView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            containerStackView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            containerStackView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            containerStackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            
            profileImageView.widthAnchor.constraint(equalTo: view.widthAnchor),
            profileImageView.heightAnchor.constraint(equalToConstant: 200),

            descriptionStackView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            descriptionStackView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor)
        ])
    }
    
    private func setupDetails() {
        fetchImageData { [weak self] image in
            self?.profileImageView.image = image
        }
        
        firstnameLabel.text = "First name: \(viewModel.user.name.first)"
        lastnameLabel.text = "Last name: \(viewModel.user.name.last)"
        birthdayLabel.text = "Birthday: \(DateFormatter.string(readable: viewModel.user.dob.date))"
        ageLabel.text = "Age: \(viewModel.user.dob.age)"
        emailLabel.text = "Email address: \(viewModel.user.email)"
        mobileLabel.text = "Mobile number: \(viewModel.user.cell)"
        addressLabel.text = "Address: \(viewModel.user.location.street.number ?? "") \(viewModel.user.location.street.name) \(viewModel.user.location.city) \(viewModel.user.location.country) \(viewModel.user.location.postcode ?? "")"
    }
    
    private func fetchImageData(completion: @escaping (UIImage?) -> ()) {
        let urlString = viewModel.user.picture.large
        ActivityIndicator.start(for: view)
        viewModel.fetchImageData(with: urlString) { result in
            if case let .success(data) = result {
                completion(UIImage(data: data))
            } else {
                completion(UIImage(named: "ImageNotAvailable"))
            }
            ActivityIndicator.stop()
        }
    }
}
