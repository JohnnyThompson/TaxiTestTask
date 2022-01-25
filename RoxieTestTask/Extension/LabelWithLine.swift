//
//  LabelWithLine.swift
//  RoxieTestTask
//
//  Created by Евгений Карпов on 21.01.2022.
//

import UIKit

class LabelWithLine: UILabel {
  convenience init(font: UIFont? = .helvetica17Bold()) {
    self.init()
    
    self.font = font
    self.translatesAutoresizingMaskIntoConstraints = false
    
    var bottomView = UIView()
    bottomView = UIView.init(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
    bottomView.backgroundColor = .lineColor()
    bottomView.translatesAutoresizingMaskIntoConstraints = false
    self.addSubview(bottomView)
    
    NSLayoutConstraint.activate([
      self.heightAnchor.constraint(equalToConstant: 40),
      bottomView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 0),
      bottomView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
      bottomView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10),
      bottomView.heightAnchor.constraint(equalToConstant: 1)
    ])
  }
}
