//
//  OrderListInteractor.swift
//  RoxieTestTask
//
//  Created by Евгений Карпов on 20.01.2022.
//

import Foundation

protocol OrderListInteractorInputProtocol: AnyObject {
  init(presenter: OrderListInteractorOutputProtocol)
  func fetchOrders()
  func getOrder(at indexPath: IndexPath)
}

protocol OrderListInteractorOutputProtocol: AnyObject {
  func ordersDidReceive(_ orders: Orders)
  func didReceiveError(with error: String)
  func orderDidReceive(_ order: Order)
}

class OrderListInteractor: OrderListInteractorInputProtocol {
  // MARK: - Properties
  unowned let presenter: OrderListInteractorOutputProtocol
  private let networkManager: NetworkManagerProtocol = NetworkManager()
  private var orders: Orders = []
  
  // MARK: - Initialization
  required init(presenter: OrderListInteractorOutputProtocol) {
    self.presenter = presenter
  }
  
  // MARK: - OrderListInteractorInputProtocol
  func fetchOrders() {
    networkManager.getOrdersList { [weak self] result in
      switch result {
      case .success(let orders):
        self?.presenter.ordersDidReceive(orders)
        self?.orders = orders
      case .failure(let error):
        self?.presenter.didReceiveError(with: error.localizedDescription)
      }
    }
  }
  
  func getOrder(at indexPath: IndexPath) {
    let order = orders[indexPath.row]
    presenter.orderDidReceive(order)
  }
}
