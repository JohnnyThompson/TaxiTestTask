//
//  UIImage+.swift
//  RoxieTestTask
//
//  Created by Евгений Карпов on 24.01.2022.
//

import UIKit

extension UIImageView {
  static func circleImageView(with color: UIColor) -> UIImageView {
    let imageView = UIImageView()
    imageView.image = UIImage(systemName: "circle") ?? UIImage()
    imageView.contentMode = .center
    imageView.preferredSymbolConfiguration = UIImage.SymbolConfiguration(weight: .heavy)
    imageView.tintColor = color
    imageView.setContentHuggingPriority(UILayoutPriority(300), for: .horizontal)
    return imageView
  }
}


