//
//  UIColor+.swift
//  RoxieTestTask
//
//  Created by Евгений Карпов on 24.01.2022.
//

import UIKit

extension UIColor {
  static func mainBlack() -> UIColor {
    UIColor(named: "mainBlack") ?? UIColor(.black)
  }
  
  static func lineColor() -> UIColor {
    return #colorLiteral(red: 0.7294117647, green: 0.7333333333, blue: 0.7411764706, alpha: 1)
  }
  
  static func mainGray() -> UIColor {
    UIColor(named: "mainGray") ?? UIColor(.gray)
  }
  
  static func mainWhite() -> UIColor {
    UIColor(named: "mainWhite") ?? UIColor(.gray)
  }
  
  static func mainYellow() -> UIColor {
    UIColor(named: "mainYellow") ?? UIColor(.yellow)
  }
}
