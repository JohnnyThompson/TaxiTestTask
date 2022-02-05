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
    UIColor(named: "lineColor") ?? UIColor(.gray)
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
