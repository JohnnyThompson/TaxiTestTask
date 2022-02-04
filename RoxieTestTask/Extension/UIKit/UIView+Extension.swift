//
//  UIView.swift
//  RoxieTestTask
//
//  Created by Евгений Карпов on 21.01.2022.
//

import UIKit

extension UIView {
  func addSubviews(_ views: [UIView]) {
    views.forEach {
      $0.translatesAutoresizingMaskIntoConstraints = false
      addSubview($0)
    }
  }
}
