//
//  OrderListTableViewCell.swift
//  RoxieTestTask
//
//  Created by Евгений Карпов on 20.01.2022.
//

import UIKit

protocol OrderListCellModelRepresentable {
  var viewModel: CellIdentifiable? { get set }
}

class OrderListTableViewCell: UITableViewCell, OrderListCellModelRepresentable {
  // MARK: - Properties
  private var dateLabel = LabelWithLine(font: .helvetica17Bold())
  private var startImage: UIImageView = .circleImageView(with: .red)
  private var startCityLabel = UILabel(font: .helvetica14Light())
  private var startAddressLabel = UILabel(font: .helvetica17())
  private var endImage: UIImageView = .circleImageView(with: .black)
  private var endCityLabel = UILabel(font: .helvetica14Light())
  private var endAddressLabel = UILabel(font: .helvetica17())
  private var priceLabel = UILabel(font: .helvetica19Bold(),
                                   lines: 0,
                                   alignment: .center)  
  var viewModel: CellIdentifiable? {
    didSet {
      setupViews()
    }
  }
  
  // MARK: - Module functions
  private func setupViews() {
    guard let cellViewModel = viewModel as? OrderListCellViewModel else {
      return
    }
    self.selectionStyle = .none
    self.backgroundColor = .clear
    self.layer.cornerRadius = 7
    
    dateLabel.text = cellViewModel.orderTime
    startCityLabel.text = cellViewModel.startCity
    startAddressLabel.text = cellViewModel.startAddress
    endCityLabel.text = cellViewModel.endCity
    endAddressLabel.text = cellViewModel.endAddress
    priceLabel.text = cellViewModel.price
    setupConstraints()
  }
  
  private func setupConstraints() {
    let view = UIView()
    view.translatesAutoresizingMaskIntoConstraints = false
    view.backgroundColor = .mainGray()
    view.layer.cornerRadius = 7
    
    let startAddressTextStackView = UIStackView(arrangedSubviews: [startCityLabel,
                                                                   startAddressLabel],
                                                axis: .vertical,
                                                spacing: 2)
    let startAddressStackView = UIStackView(arrangedSubviews: [startImage,
                                                               startAddressTextStackView],
                                            axis: .horizontal,
                                            spacing: 10)
    let endAddressTextStackView = UIStackView(arrangedSubviews: [endCityLabel,
                                                                 endAddressLabel],
                                              axis: .vertical,
                                              spacing: 2)
    let endAddressStackView = UIStackView(arrangedSubviews: [endImage,
                                                             endAddressTextStackView],
                                          axis: .horizontal,
                                          spacing: 10)
    let addressStackView = UIStackView(arrangedSubviews: [startAddressStackView,
                                                          endAddressStackView],
                                       axis: .vertical,
                                       spacing: 10)
    let orderStackView = UIStackView(arrangedSubviews: [addressStackView,
                                                        priceLabel],
                                     axis: .horizontal,
                                     spacing: 10)
    addSubview(view)
    view.addSubviews([dateLabel, orderStackView])
    
    NSLayoutConstraint.activate([
      view.topAnchor.constraint(equalTo: self.topAnchor, constant: 5),
      view.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 5),
      view.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -10),
      view.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -5),
      
      dateLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 0),
      dateLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
      dateLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
      
      priceLabel.widthAnchor.constraint(equalToConstant: 80),
      
      orderStackView.topAnchor.constraint(equalTo: dateLabel.bottomAnchor, constant: 10),
      orderStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
      orderStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
      orderStackView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -10)
    ])
  }
  
}

