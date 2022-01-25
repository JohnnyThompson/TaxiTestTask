//
//  OrderListCellViewModel.swift
//  RoxieTestTask
//
//  Created by Евгений Карпов on 20.01.2022.
//

import Foundation

protocol CellIdentifiable {
  var cellIdentifier: String { get }
}

protocol SectionRowPresentable {
  var rows: [CellIdentifiable] { get set }
}

class OrderListCellViewModel: CellIdentifiable {
  // MARK: - Properties
  let orderTime: String
  let startCity: String
  let startAddress: String
  let endCity: String
  let endAddress: String
  let price: String
  var cellIdentifier: String {
    "OrderCell"
  }
  
  // MARK: - Initialization
  init(order: Order) {
    let formatter = DateFormatter()
    formatter.dateFormat = "d MMMM yyyy, EEEE"
    orderTime = formatter.string(from: order.orderTime)
    startCity = order.startAddress.city
    startAddress = order.startAddress.address
    endCity = order.endAddress.city
    endAddress = order.endAddress.address
    price = "\(order.price.amount / 100).\(order.price.amount % 100)\n\(order.price.currency)"
  }
}

class OrderSectionViewModel: SectionRowPresentable {
    var rows: [CellIdentifiable] = []
}
