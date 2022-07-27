//
//  PeopleDetailsController.swift
//  RandomMe
//
//  Created by Marwin Carino on 7/27/22.
//

import Foundation
import UIKit

class PeopleDetailsController: UIViewController {
  var viewModel: PeopleDetailsViewModel!

  private let placeholderImage = R.image.avatar_placeholder()

  // MARK: - IBOutlets

  @IBOutlet var thumbnailImageView: UIImageView!
  @IBOutlet var nameLabel: UILabel!
  @IBOutlet var addressLabel: UILabel!
  @IBOutlet var emailLabel: UILabel!
  @IBOutlet var phoneLabel: UILabel!
  @IBOutlet var birthDateLabel: UILabel!

  override func viewDidLoad() {
    super.viewDidLoad()

    reset()
    setup()
  }
}

// MARK: - Setup

private extension PeopleDetailsController {
  func reset() {
    thumbnailImageView.image = nil
    nameLabel.text = nil
    addressLabel.text = nil
    emailLabel.text = nil
    phoneLabel.text = nil
    birthDateLabel.text = nil
  }

  func setup() {
    thumbnailImageView.layer.cornerRadius = thumbnailImageView.frame.size.height / 2
    thumbnailImageView.layer.borderColor = UIColor.green.cgColor
    thumbnailImageView.layer.borderWidth = 2

    if let imageURL = viewModel.thumbnailImageURL {
      thumbnailImageView.loadImage(
        from: imageURL,
        placeholder: placeholderImage
      )
    } else {
      thumbnailImageView.image = placeholderImage
    }

    nameLabel.text = viewModel.nameText
    addressLabel.text = viewModel.addressText
    emailLabel.text = viewModel.emailText
    phoneLabel.text = viewModel.phoneText
    birthDateLabel.text = viewModel.birthDateText
  }
}
