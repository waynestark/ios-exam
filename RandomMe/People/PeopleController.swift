//
//  PeopleController.swift
//  RandomMe
//
//  Created by Marwin Carino on 7/26/22.
//

import Foundation
import UIKit

import NSObject_Rx
import RxCocoa
import RxSwift

import SVProgressHUD

class PeopleController: UIViewController {
  // MARK: - Properties

  private var gender = PublishSubject<Gender>()
  private let refreshControl = UIRefreshControl()

  var viewModel: PeopleViewModel!

  // MARK: - IBOutlets

  @IBOutlet var segmentedControl: UISegmentedControl!
  @IBOutlet var tableView: UITableView!
  @IBOutlet var stateLabel: UILabel!

  // MARK: - Life Cycle

  override func viewDidLoad() {
    super.viewDidLoad()

    setup()
    bind()
  }

  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
  }
}

// MARK: - Setup

private extension PeopleController {
  func setup() {
    setupSegmentedControl()
    setupTableView()

    refreshStateLabel()
  }

  func setupSegmentedControl() {
    segmentedControl.removeAllSegments()

    viewModel.genders.enumerated().forEach { index, gender in
      segmentedControl.insertSegment(
        withTitle: gender.rawValue.uppercased(),
        at: index,
        animated: false
      )
    }

    guard let index = viewModel.genders.firstIndex(of: viewModel.gender) else {
      preconditionFailure("Expected defaultGender to be included the list of genders")
    }

    segmentedControl.selectedSegmentIndex = index
  }

  func setupTableView() {
    tableView.register(cellType: PeopleTableCell.self)

    tableView.separatorStyle = .none
    tableView.refreshControl = refreshControl
    tableView.delegate = self
    tableView.dataSource = self

    tableView.reloadData()
  }
}

// MARK: - Bindings

private extension PeopleController {
  func bind() {
    bindSegmentedControl()
    bindRefreshControl()
    bindState()
  }

  func bindSegmentedControl() {
    segmentedControl.rx
      .selectedSegmentIndex
      .subscribe(onNext: { [weak self] index in
        guard let self = self else { return }

        self.viewModel.selectGender(at: index)
        self.viewModel.load()
        self.scrollToTop()
      })
      .disposed(by: rx.disposeBag)
  }

  func bindRefreshControl() {
    refreshControl.rx
      .controlEvent(.valueChanged)
      .subscribe(onNext: { [weak self] in
        guard let self = self else { return }

        self.viewModel.refresh()
      })
      .disposed(by: rx.disposeBag)
  }

  func bindState() {
    viewModel.state.subscribe(
      onNext: { [weak self] state in
        guard let self = self else { return }

        switch state {
        case .loading:
          SVProgressHUD.show()
        case .empty,
             .ready:
          if SVProgressHUD.isVisible() {
            SVProgressHUD.dismiss()
          }

          self.tableView.reloadData()
          self.refreshStateLabel()
        case .error:
          SVProgressHUD.showError(withStatus: S.errorGeneralMessage())

          self.tableView.reloadData()
          self.refreshStateLabel()
        }

        if self.refreshControl.isRefreshing {
          self.refreshControl.endRefreshing()
        }
      })
      .disposed(by: rx.disposeBag)
  }
}

// MARK: - Methods

private extension PeopleController {
  func refreshStateLabel() {
    stateLabel.isHidden = !viewModel.people.isEmpty
  }

  private func scrollToTop() {
    tableView.setContentOffset(.zero, animated: true)
  }
}

// MARK: - UITableView

extension PeopleController: UITableViewDataSource, UITableViewDelegate {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return viewModel.people.count
  }

  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(for: indexPath) as PeopleTableCell
    cell.viewModel = viewModel.createPeopleTableCellVM(for: indexPath)

    return cell
  }

  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return PeopleTableCell.idealHeight
  }

  func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
    if indexPath.row == viewModel.people.count - 1 {
      viewModel.loadNextPage()
    }
  }

  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    navigateToPeopleDetails(for: indexPath)
  }
}

// MARK: - Navigation

private extension PeopleController {
  func navigateToPeopleDetails(for indexPath: IndexPath) {
    let controller = R.storyboard.people.peopleDetailsController()!
    controller.viewModel = viewModel.createPeopleDetailsCellVM(for: indexPath)

    showDetailViewController(controller, sender: self)
  }
}
