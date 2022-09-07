//
//  UICollectionView+Utils.swift
//  Contacts
//
//  Created by Cielo Reyes on 9/5/22.
//

import Rswift
import UIKit

extension UICollectionView {
  func register(_ cellNib: NibResourceType) {
    register(UINib(resource: cellNib), forCellWithReuseIdentifier: cellNib.name)
  }

  func registerHeader<T: UICollectionReusableView>(_ cell: T.Type) {
    register(
      T.self,
      forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
      withReuseIdentifier: T.reuseIdentifier
    )
  }

  func dequeueCell<T: UICollectionViewCell>(_ cell: T.Type, for indexPath: IndexPath) -> T? {
    dequeueReusableCell(withReuseIdentifier: T.reuseIdentifier, for: indexPath) as? T
  }

  func dequeueSupplementaryView<T: UICollectionReusableView>(
    _ cell: T.Type,
    for indexPath: IndexPath,
    ofKind: String
  ) -> T? {
    dequeueReusableSupplementaryView(
      ofKind: ofKind,
      withReuseIdentifier: T.reuseIdentifier,
      for: indexPath
    ) as? T
  }
}

extension UICollectionReusableView {
  static var reuseIdentifier: String {
    String(describing: self)
  }
}
