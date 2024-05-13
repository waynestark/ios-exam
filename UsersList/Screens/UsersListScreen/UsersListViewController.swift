//
//  UsersListViewController.swift
//  UsersList
//
//  Created by Marc Jardine Esperas on 11/16/22.
//

import UIKit

class UsersListViewController: UIViewController {
    
    private struct UserCell { static let reuseIdentifier = "UserTableViewCell" }
    
    var viewModel: UsersListViewModelProtocol
    
    var tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.rowHeight = 104
        tableView.register(UserTableViewCell.self, forCellReuseIdentifier: UserCell.reuseIdentifier)
        return tableView
    }()
    
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
    
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    
    init(viewModel: UsersListViewModelProtocol) {
        self.viewModel = viewModel
        
        super.init(nibName: nil, bundle: nil)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Users List"
        configureTableView()
        fetchUsers()
    }
    
    private func configureTableView() {
        view.addSubview(tableView)
        layoutComponents()
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    private func layoutComponents() {
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }

// MARK: API Calls
    private func fetchUsers() {
        ActivityIndicator.start(for: view)
        
        viewModel.fetchUsers { [weak self] response in
            switch response {
                case .success():
                    self?.tableView.reloadData()
                case .failure(let error):
                    self?.showAlert(message: error.localizedDescription)
            }
            ActivityIndicator.stop()
        }
    }
    
    private func fetchImageData(urlString: String, completion: @escaping (UIImage?) -> ()) {
        viewModel.fetchImageData(with: urlString) { result in
            if case let .success(data) = result {
                completion(UIImage(data: data))
            } else {
                completion(UIImage(named: "ImageNotAvailable"))
            }
        }
    }
}

// MARK: UITableViewDataSource
extension UsersListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfItems(in: section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell: UserTableViewCell = self.tableView.dequeueReusableCell(withIdentifier: UserCell.reuseIdentifier) as? UserTableViewCell else {
            fatalError("UserTableViewCell not found")
        }
        
        let user: User = viewModel.user(at: indexPath.row)

        fetchImageData(urlString: user.picture.medium) { image in
            DispatchQueue.main.async {
                cell.setThumbnail(image: image)
            }
        }
        
        cell.setLabels(user: user)
        
        return cell
    }
}

// MARK: UITableViewDelegate
extension UsersListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let user: User = viewModel.user(at: indexPath.row)
        let viewModel: UserProfileViewModelProtocol = UserProfileViewModel(user: user)
        gotoUserProfileViewController(viewModel: viewModel)
    }
}

// MARK: Navigation
extension UsersListViewController {
    func gotoUserProfileViewController(viewModel: UserProfileViewModelProtocol) {
        let viewController = UserProfileViewController.init(viewModel: viewModel)
        navigationController?.pushViewController(viewController, animated: true)
    }
}
