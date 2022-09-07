//
//  PersonDetailController.swift
//  Contacts
//
//  Created by Cielo Reyes on 9/5/22.
//

import AlamofireImage
import Hero
import UIKit

final class PersonDetailController: UIViewController {
  var viewModel: PersonDetailViewModelProtocol!

  @IBOutlet private var bgImage: UIImageView!
  @IBOutlet private var avatar: UIImageView!
  @IBOutlet private var avatarContainer: UIView!
  @IBOutlet private var backButton: UIButton!

  @IBOutlet private var fullNameContainer: UIView!
  @IBOutlet private var detailsContainer: UIView!
  @IBOutlet private var fullNameLabel: UILabel!
  @IBOutlet private var firstNameLabel: UILabel!
  @IBOutlet private var lastNameLabel: UILabel!
  @IBOutlet private var mobileNumberLabel: UILabel!
  @IBOutlet private var emailLabel: UILabel!
  @IBOutlet private var birthdayLabel: UILabel!
  @IBOutlet private var ageLabel: UILabel!
  @IBOutlet private var addressLabel: UILabel!
  @IBOutlet private var contactPersonNameLabel: UILabel!
  @IBOutlet private var contactPersonNumberLabel: UILabel!

  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = .red

    setup()
  }

  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)

    setupBgBlurredImage()
  }
}

// MARK: - Setup

private extension PersonDetailController {
  func setup() {
    setupAvatar()
    setupBackButton()
    setupVM()
  }

  func setupVM() {
    guard viewModel != nil else { return }

    bgImage.hero.id = viewModel.personId
    fullNameContainer.hero.id = viewModel.emailText
    avatar.af.setImage(
      withURL: viewModel.avatarURL,
      completion: handleAvatarDownload()
    )

    fullNameLabel.text = viewModel.fullNameText
    firstNameLabel.text = viewModel.firstNameText
    lastNameLabel.text = viewModel.lastNameText
    mobileNumberLabel.text = viewModel.mobileNumberText
    emailLabel.text = viewModel.emailText
    birthdayLabel.text = viewModel.birthdayText
    ageLabel.text = viewModel.ageText
    addressLabel.text = viewModel.addressText
    contactPersonNameLabel.text = viewModel.contactPersonNameText
    contactPersonNumberLabel.text = viewModel.contactPersonNumberText
  }

  func setupAvatar() {
    avatar.layer.cornerRadius = avatar.bounds.width / 2

    avatarContainer.layer.borderColor = UIColor.white.cgColor
    avatarContainer.layer.borderWidth = 1
    avatarContainer.layer.masksToBounds = false
    avatarContainer.layer.shadowOffset = CGSize(width: 2.0, height: 4.0)
    avatarContainer.layer.shadowRadius = 10.0
    avatarContainer.layer.shadowOpacity = 0.5
    avatarContainer.layer.cornerRadius = avatar.bounds.width / 2
    avatarContainer.layer.shadowPath = UIBezierPath(
      roundedRect: avatarContainer.bounds,
      cornerRadius: avatarContainer.layer.cornerRadius
    ).cgPath
  }

  func setupBackButton() {
    backButton.layer.masksToBounds = false
    backButton.layer.shadowOffset = CGSize(width: 1.0, height: 2.0)
    backButton.layer.shadowRadius = 2.0
    backButton.layer.shadowOpacity = 0.5
  }

  func setupBgBlurredImage() {
    guard let image = avatar.image else {
      return setupShowDetails()
    }

    let blurredImage = image.af.imageFiltered(
      withCoreImageFilter: "CIGaussianBlur",
      parameters: ["inputRadius": 25]
    )

    return setupShowDetails(blurredImage)
  }

  func setupShowDetails(_ blurredBgImage: UIImage? = nil) {
    bgImage.hero.id = nil
    avatar.hero.id = viewModel.personId

    UIView.animate(withDuration: 0.3) { [weak self] in
      guard let self = self else { return }

      self.avatarContainer.alpha = 1
      self.fullNameContainer.alpha = 1
      self.detailsContainer.alpha = 1
      self.bgImage.image = blurredBgImage
    }
  }
}

// MARK: - Actions

private extension PersonDetailController {
  @IBAction
  func dissmiss() {
    dismiss(animated: true)
  }
}

// MARK: - Helpers

private extension PersonDetailController {
  func handleAvatarDownload() -> (AFIDataResponse<UIImage>) -> Void {
    return { [weak self] response in
      guard let self = self else { return }
      switch response.result {
      case let .success(image):
        self.bgImage.image = image
      case let .failure(error):
        debugPrint("error: \(error)")
      }
    }
  }
}
