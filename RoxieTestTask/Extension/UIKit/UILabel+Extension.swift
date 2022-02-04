//
//  UILabel+.swift
//  RoxieTestTask
//
//  Created by Евгений Карпов on 24.01.2022.
//

import UIKit

extension UILabel {
  
  convenience init(text: String = "",
                   font: UIFont?,
                   color: UIColor = .mainBlack(),
                   lines: Int = 1,
                   alignment: NSTextAlignment = .left) {
    self.init()
    
    self.text = text
    self.textColor = color
    self.font = font
    self.adjustsFontSizeToFitWidth = true
    self.numberOfLines = lines
    self.textAlignment = alignment
  }
}
