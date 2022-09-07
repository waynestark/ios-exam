//
//  FavoriteCell.swift
//  Contacts
//
//  Created by Cielo Reyes on 9/5/22.
//

import AlamofireImage
import Hero
import RxCocoa
import RxSwift
import UIKit

final class FavoriteCell: UICollectionViewCell {
  var viewModel: ContactCellViewModelProtocol! {
    didSet {
      refresh()
    }
  }

  @IBOutlet private var containerView: UIView!
  @IBOutlet private var fullNameContainerView: UIView!
  @IBOutlet private var favoriteButton: UIButton!
  @IBOutlet private var avatar: UIImageView!
  @IBOutlet private var nameLabel: UILabel!
  @IBOutlet private var mobileNumberLabel: UILabel!
  @IBOutlet private var emailLabel: UILabel!
  @IBOutlet private var birthdayLabel: UILabel!

  private var disposeBag = DisposeBag()

  override func awakeFromNib() {
    setup()
  }
}

// MARK: - Setup

private extension FavoriteCell {
  func setup() {
    setupFavoriteButton()
    containerView.layer.cornerRadius = 8

    avatar.image = nil
    layer.masksToBounds = false
    layer.shadowOffset = CGSize(width: 1.0, height: 2.0)
    layer.shadowRadius = 4.0
    layer.shadowOpacity = 0.25
  }

  func setupFavoriteButton() {
    favoriteButton.layer.masksToBounds = false
    favoriteButton.layer.shadowOffset = CGSize(width: 1.0, height: 2.0)
    favoriteButton.layer.shadowRadius = 4.0
    favoriteButton.layer.shadowOpacity = 0.75

    favoriteButton.rx.tap
      .bind(onNext: handleFavoriteTapped())
      .disposed(by: disposeBag)
  }
}

// MARK: - Refresh

private extension FavoriteCell {
  func refresh() {
    guard viewModel != nil else { return }

    avatar.hero.id = viewModel.personId
    fullNameContainerView.hero.id = viewModel.emailText
    avatar.af.setImage(withURL: viewModel.avatarURL)
    nameLabel.text = viewModel.fullNameText
    mobileNumberLabel.text = viewModel.mobileNumberText
    emailLabel.text = viewModel.emailText
    birthdayLabel.text = viewModel.birthdayText
  }

  func handleFavoriteTapped() -> VoidResult {
    return { [weak self] in
      guard let self = self else { return }
      self.viewModel.markFavorite()
      self.avatar.hero.id = nil
      self.fullNameContainerView.hero.id = nil
    }
  }
}
