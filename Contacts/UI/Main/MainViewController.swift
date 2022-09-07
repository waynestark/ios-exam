//
//  MainViewController.swift
//  Contacts
//
//  Created by Cielo Reyes on 9/5/22.
//

import Hero
import RxCocoa
import RxSwift
import UIKit

final class MainViewController: UIViewController {
  var viewModel: MainViewModelProtocol!
  var onDetails: DetailResult?

  typealias DataSource = UICollectionViewDiffableDataSource<SectionType, ContactCellViewModel>
  typealias Snapshot = NSDiffableDataSourceSnapshot<SectionType, ContactCellViewModel>

  @IBOutlet private var collectionView: UICollectionView!

  private lazy var dataSource = createDataSource()
  private var refreshControl = UIRefreshControl()
  private let disposeBag = DisposeBag()
}

// MARK: - Lifecycle

extension MainViewController {
  override func viewDidLoad() {
    super.viewDidLoad()
    setup()
  }
}

// MARK: - Setup

private extension MainViewController {
  func setup() {
    title = R.string.localizable.title()
    navigationController?.navigationBar.prefersLargeTitles = true
    navigationController?.navigationItem.largeTitleDisplayMode = .always

    setupCollectionView()
    setupRefreshControl()
    fetchContacts()
  }

  func setupCollectionView() {
    collectionView.register(R.nib.favoriteCell)
    collectionView.register(R.nib.contactCell)
    collectionView.registerHeader(TitleHeaderView.self)

    collectionView.collectionViewLayout = collectionViewLayout
    collectionView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 20, right: 0)
  }

  func setupRefreshControl() {
    refreshControl.rx.controlEvent(.valueChanged)
      .subscribe(onNext: { [weak self] in
        guard let self = self else { return }
        self.fetchContacts(fromServer: true)
      })
      .disposed(by: disposeBag)

    collectionView.refreshControl = refreshControl
  }
}

// MARK: - Functions

private extension MainViewController {
  func fetchContacts(fromServer: Bool = false) {
    guard !viewModel.isLoading else { return }
    viewModel.fetchContacts(
      fromServer: fromServer,
      onSuccess: handleFetchSuccess(),
      onError: handleFetchError()
    )
  }
}

// MARK: - Handler

private extension MainViewController {
  func handleFetchSuccess() -> VoidResult {
    return { [weak self] in
      guard let self = self else { return }
      self.applySnapshot()
      self.refreshControl.endRefreshing()
    }
  }

  func handleFetchError() -> ErrorResult {
    return { [weak self] _ in
      guard let self = self else { return }
      self.refreshControl.endRefreshing()
    }
  }

  func handleFavoriteTapped(_ cellVM: ContactCellViewModel) -> VoidResult {
    return { [weak self] in
      guard let self = self else { return }

      self.viewModel.markFavorite(for: cellVM) {
        self.applySnapshot(specificType: cellVM.type)
      }
    }
  }
}

// MARK: - CollectionView Delegate

extension MainViewController: UICollectionViewDelegate {
  func collectionView(
    _ collectionView: UICollectionView,
    didSelectItemAt indexPath: IndexPath
  ) {
    let person = viewModel.personObject(for: indexPath)
    onDetails?(person)
  }

  func collectionView(
    _ collectionView: UICollectionView,
    didEndDisplaying cell: UICollectionViewCell,
    forItemAt indexPath: IndexPath
  ) {
    cell.hero.isEnabled = false
  }

  func collectionView(
    _ collectionView: UICollectionView,
    willDisplay cell: UICollectionViewCell,
    forItemAt indexPath: IndexPath
  ) {
    cell.hero.isEnabled = true
  }
}

// MARK: - CollectionView Layout And Config

private extension MainViewController {
  func applySnapshot(animatingDifferences: Bool = true, specificType: SectionType? = nil) {
    guard viewModel.mainSections.count > 0 else { return }

    var snapshot = Snapshot()

    let sections = viewModel.mainSections

    snapshot.appendSections(sections)
    if !viewModel.favoriteCellVMs.isEmpty {
      snapshot.appendItems(viewModel.favoriteCellVMs, toSection: .favorite)
    }
    if !viewModel.contactCellVMs.isEmpty {
      snapshot.appendItems(viewModel.contactCellVMs, toSection: .contact)
    }

    if let sectionType = specificType {
      if sectionType == .favorite && !viewModel.favoriteCellVMs.isEmpty {
        snapshot.reloadItems(viewModel.favoriteCellVMs)
      } else if !viewModel.contactCellVMs.isEmpty {
        snapshot.reloadItems(viewModel.contactCellVMs)
      }
    }

    dataSource.apply(snapshot, animatingDifferences: animatingDifferences)
  }

  func createDataSource() -> DataSource {
    let dataSource = DataSource(
      collectionView: collectionView,
      cellProvider: cellProviderHandler()
    )

    dataSource.supplementaryViewProvider = supplementaryProviderHandler()

    return dataSource
  }

  var contactSection: NSCollectionLayoutSection {
    let itemSize = NSCollectionLayoutSize(
      widthDimension: .fractionalWidth(0.44),
      heightDimension: .fractionalHeight(1)
    )

    let item = NSCollectionLayoutItem(layoutSize: itemSize)
    item.edgeSpacing = NSCollectionLayoutEdgeSpacing(
      leading: .fixed(16),
      top: .fixed(4),
      trailing: .flexible(0),
      bottom: .fixed(16)
    )

    let item2 = NSCollectionLayoutItem(layoutSize: itemSize)
    item2.edgeSpacing = NSCollectionLayoutEdgeSpacing(
      leading: .flexible(0),
      top: .fixed(4),
      trailing: .fixed(16),
      bottom: .fixed(16)
    )

    let groupSize = NSCollectionLayoutSize(
      widthDimension: .fractionalWidth(1.0),
      heightDimension: .fractionalWidth(0.66)
    )

    let group = NSCollectionLayoutGroup.horizontal(
      layoutSize: groupSize,
      subitems: [item, item2]
    )

    let section = NSCollectionLayoutSection(group: group)
    section.interGroupSpacing = 16

    section.boundarySupplementaryItems = [collectionHeader]

    return section
  }

  var favoriteSection: NSCollectionLayoutSection {
    let itemSize = NSCollectionLayoutSize(
      widthDimension: .fractionalWidth(1.0),
      heightDimension: .fractionalWidth(0.5)
    )
    let item = NSCollectionLayoutItem(layoutSize: itemSize)
    item.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 16, bottom: 8, trailing: 16)

    let groupSize = NSCollectionLayoutSize(
      widthDimension: .fractionalWidth(1.0),
      heightDimension: .fractionalWidth(0.5)
    )
    let group = NSCollectionLayoutGroup.horizontal(
      layoutSize: groupSize,
      subitem: item,
      count: 1
    )

    let section = NSCollectionLayoutSection(group: group)
    section.orthogonalScrollingBehavior = .paging

    section.boundarySupplementaryItems = [collectionHeader]

    return section
  }

  var collectionHeader: NSCollectionLayoutBoundarySupplementaryItem {
    let headerSize = NSCollectionLayoutSize(
      widthDimension: .fractionalWidth(1.0),
      heightDimension: .absolute(30)
    )

    let header = NSCollectionLayoutBoundarySupplementaryItem(
      layoutSize: headerSize,
      elementKind: UICollectionView.elementKindSectionHeader,
      alignment: .top
    )

    return header
  }

  var collectionViewLayout: UICollectionViewLayout {
    return UICollectionViewCompositionalLayout { [unowned self] sectionNumber, _ -> NSCollectionLayoutSection? in
      guard sectionNumber < self.viewModel.mainSections.count else { return self.contactSection }
      let section = self.viewModel.mainSections[sectionNumber]

      switch section {
      case .favorite:
        return self.favoriteSection
      case .contact:
        return self.contactSection
      }
    }
  }
}

// MARK: - CollectionView Cell and Header Handler

private extension MainViewController {
  func cellProviderHandler() -> DataSource.CellProvider {
    return { [weak self] _, indexPath, contactVM in
      guard let self = self else { return nil }

      switch contactVM.type {
      case .favorite:
        return self.configureFavoriteCell(
          for: indexPath,
          contactCellVM: contactVM
        )
      case .contact:
        return self.configureContactCell(
          for: indexPath,
          contactCellVM: contactVM
        )
      }
    }
  }

  func supplementaryProviderHandler() -> DataSource.SupplementaryViewProvider {
    return { collectionView, kind, indexPath in
      if kind == UICollectionView.elementKindSectionHeader {
        guard let headerView = collectionView.dequeueSupplementaryView(
          TitleHeaderView.self,
          for: indexPath,
          ofKind: kind
        ) else { return nil }

        let section = self.dataSource.snapshot().sectionIdentifiers[indexPath.section]
        headerView.text = section.title

        return headerView
      }

      return nil
    }
  }

  func configureFavoriteCell(
    for indexPath: IndexPath,
    contactCellVM: ContactCellViewModel
  ) -> FavoriteCell? {
    guard let cell = collectionView.dequeueCell(FavoriteCell.self, for: indexPath)
    else { return nil }

    cell.viewModel = contactCellVM
    cell.viewModel.favoriteTapped = handleFavoriteTapped(contactCellVM)

    return cell
  }

  func configureContactCell(
    for indexPath: IndexPath,
    contactCellVM: ContactCellViewModel
  ) -> ContactCell? {
    guard let cell = collectionView.dequeueCell(ContactCell.self, for: indexPath)
    else { return nil }

    cell.viewModel = contactCellVM
    cell.viewModel.favoriteTapped = handleFavoriteTapped(contactCellVM)

    return cell
  }
}
