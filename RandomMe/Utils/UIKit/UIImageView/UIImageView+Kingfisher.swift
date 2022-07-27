//
//  UIImageView+Kingfisher.swift
//  RandomMe
//
//  Created by Marwin Carino on 7/27/22.
//

import Foundation
import UIKit

extension UIImageView {
    func loadImage(from url: URL, placeholder: UIImage? = nil) {
        self.kf.indicatorType = .activity
        self.kf.setImage(
          with: url,
          placeholder: placeholder,
          options: [
            .scaleFactor(UIScreen.main.scale),
            .transition(.fade(1)),
            .cacheOriginalImage
          ]
        )
    }
}
