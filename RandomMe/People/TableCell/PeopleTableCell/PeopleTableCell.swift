//
//  PeopleTableCell.swift
//  RandomMe
//
//  Created by Marwin Carino on 7/27/22.
//

import Foundation
import Kingfisher
import Reusable
import UIKit

class PeopleTableCell: UITableViewCell, NibReusable {
  // MARK: Properties

  var viewModel: PeopleTableCellViewModel! {
    didSet {
      refresh()
    }
  }

  private let thumbnailPlaceholderImage = R.image.avatar_placeholder()

  // MARK: - IBOutlets

  @IBOutlet var thumbnailImageView: UIImageView!
  @IBOutlet var nameLabel: UILabel!
  @IBOutlet var addressLabel: UILabel!
  @IBOutlet var emailLabel: UILabel!
  @IBOutlet var phoneLabel: UILabel!

  override func awakeFromNib() {
    super.awakeFromNib()

    setup()
  }
}

// MARK: - Setup

private extension PeopleTableCell {
  func setup() {
    selectionStyle = .none

    thumbnailImageView.image = nil
    thumbnailImageView.layer.cornerRadius = thumbnailImageView.frame.size.height / 2
    thumbnailImageView.layer.borderColor = UIColor.green.cgColor
    thumbnailImageView.layer.borderWidth = 1

    nameLabel.text = nil
    addressLabel.text = nil
    emailLabel.text = nil
    phoneLabel.text = nil
  }
}

// MARK: - Refresh

private extension PeopleTableCell {
  func refresh() {
    if let thumbnailURL = viewModel.thumbnailURL {
      thumbnailImageView.loadImage(
        from: thumbnailURL,
        placeholder: thumbnailPlaceholderImage
      )
    } else {
      thumbnailImageView.image = thumbnailPlaceholderImage
    }

    nameLabel.text = viewModel.nameText
    addressLabel.text = viewModel.addressText
    phoneLabel.text = viewModel.phoneText
    emailLabel.text = viewModel.emailText
  }
}

// MARK: - Methods

// MARK: - Constants

extension PeopleTableCell {
  static let idealHeight = 84.0
}
