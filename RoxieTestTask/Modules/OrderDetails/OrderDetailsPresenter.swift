//
//  OrderDetailsPresenter.swift
//  RoxieTestTask
//
//  Created by Евгений Карпов on 20.01.2022.
//

import Foundation
struct OrderDetailsImage{
  let vehicleImage: Data?
}
struct OrderDetailsData {
  let orderTime: String
  let modelName: String
  let regNumber: String
  let driverName: String
}

class OrderDetailsPresenter: OrderDetailsViewOutputProtocol {
  // MARK: - Properties
  unowned let view: OrderDetailsViewInputProtocol
  var interactor: OrderDetailsInteractorInputProtocol!
  
  // MARK: - Initialization
  required init(view: OrderDetailsViewInputProtocol) {
    self.view = view
  }
  
  // MARK: - OrderDetailsViewOutputProtocol
  func showDetails() {
    interactor.provideOrderDetails()
    interactor.provideOrderImage()
  }
}

// MARK: - OrderDetailsInteractorOutputProtocol
extension OrderDetailsPresenter: OrderDetailsInteractorOutputProtocol {
  func receiveOrderDetailsImage(with orderData: OrderDetailsImage) {
    guard let imageData = orderData.vehicleImage else {
      return
    }
    view.displayVehicleImage(with: imageData)
  }
  
  func receiveOrderDetails(with orderData: OrderDetailsData) {
    let orderDate = "Дата заказа: \(orderData.orderTime)"
    let modelName = "Автомобиль: \(orderData.modelName)"
    let regNumber = "Регистрационный номер: \(orderData.regNumber)"
    let driverName = "Водитель: \(orderData.driverName)"
    view.displayOrderTime(with: orderDate)
    view.displayModelNameLabel(with: modelName)
    view.displayRegNumber(with: regNumber)
    view.displayDriverName(with: driverName)
  }
  
  func didReceiveError(with error: String) {
    view.showAlert(with: error)
  }
  
  func receiveOrderDetailsImageCache(with cacheKey: String) {
    view.displayVehicleImage(from: cacheKey)
  }
}
