//
//  TitleHeaderView.swift
//  Contacts
//
//  Created by Cielo Reyes on 9/6/22.
//

import UIKit

class TitleHeaderView: UICollectionReusableView {
  override init(frame: CGRect) {
    super.init(frame: frame)
  }

  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
  }

  var text: String = "" {
    didSet {
      textLabel.text = text
      setupText()
    }
  }

  var height: CGFloat = 0

  private var textLabel: UILabel = {
    let label = UILabel()
    label.font = .boldSystemFont(ofSize: 18)
    label.textAlignment = .left
    label.backgroundColor = .clear

    return label
  }()

  func setupText() {
    let frame = CGRect(
      origin: CGPoint(x: 16, y: 2),
      size: CGSize(width: UIScreen.main.bounds.size.width - 32, height: 40)
    )
    addSubview(textLabel)
    textLabel.frame = frame
    textLabel.text = text
    textLabel.sizeToFit()
  }
}
