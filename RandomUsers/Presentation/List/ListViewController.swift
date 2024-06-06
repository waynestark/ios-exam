//
//  ListViewController.swift
//  RandomUsers
//
//  Created by jmmanoza on 6/5/24.
//

import UIKit
import Combine

class ListViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var viewModel: UserListViewModel
    var onPersonSelected: ((Person) -> Void)?
    private var cancellables = Set<AnyCancellable>()
    private let mainSpinner = UIActivityIndicatorView(style: .medium)
    
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(UserCell.self, forCellReuseIdentifier: UserCell.identifier)
        return tableView
    }()
    private var refreshControl = UIRefreshControl()
    
    init(viewModel: UserListViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
 
        let userRepository = UserRepositoryImpl(apiService: APIService.shared,
                                                localDatabaseService: LocalDatabaseService.shared)
        let fetchUsersUseCase = FetchUsersUseCaseImpl(userRepository: userRepository)

        self.viewModel = UserListViewModel(fetchUsersUseCase: fetchUsersUseCase)
        super.init(coder: coder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
 
        self.title = "Random Users List"

        setupTableView()
        setUpSpinner()
        fetchUsers()
    }
    
    private func setupTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        
        view.addSubview(tableView)
        tableView.rowHeight = 80
        tableView.frame = view.bounds
    }
    
    private func setupBindings() {
        self.viewModel.$users.sink { [weak self] _ in
            self?.tableView.reloadData()
            self?.mainSpinner.stopAnimating()
        }.store(in: &cancellables)
    }
    
    private func fetchUsers() {
        Task {
            await viewModel.fetchUsers()
            self.tableView.reloadData()
            self.mainSpinner.stopAnimating()
        }
    }
    
    private func setUpSpinner() {
        mainSpinner.hidesWhenStopped = true
        mainSpinner.translatesAutoresizingMaskIntoConstraints = false
        mainSpinner.startAnimating()
        view.addSubview(mainSpinner)
        
        mainSpinner.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        mainSpinner.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }
    
    private func tableViewFooterSpinner() {
        let spinner = UIActivityIndicatorView(style: .medium)
        spinner.startAnimating()
        spinner.frame = CGRect(x: CGFloat(0), y: CGFloat(0), width: tableView.bounds.width, height: CGFloat(44))
        
        self.tableView.tableFooterView = spinner
        self.tableView.tableFooterView?.isHidden = false
    }
}

extension ListViewController {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.users.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: UserCell.identifier, for: indexPath) as! UserCell
        cell.configure(with: viewModel.users[indexPath.row])
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row == viewModel.users.count - 1 {
            fetchUsers()
            tableViewFooterSpinner()
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let person = viewModel.users[indexPath.row]
        onPersonSelected?(person)
        tableView.deselectRow(at: indexPath, animated: false)
    }
}


