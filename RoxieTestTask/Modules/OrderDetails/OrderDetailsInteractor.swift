//
//  OrderDetailsInteractor.swift
//  RoxieTestTask
//
//  Created by Евгений Карпов on 20.01.2022.
//

import Foundation

protocol OrderDetailsInteractorInputProtocol: AnyObject {
  init(presenter: OrderDetailsInteractorOutputProtocol, order: Order)
  func provideOrderDetails()
  func provideOrderImage()
}

protocol OrderDetailsInteractorOutputProtocol: AnyObject {
  func receiveOrderDetails(with orderData: OrderDetailsData)
  func receiveOrderDetailsImage(with orderData: OrderDetailsImage)
  func receiveOrderDetailsImageCache(with cacheKey: String)
  func didReceiveError(with error: String)
}

class OrderDetailsInteractor: OrderDetailsInteractorInputProtocol{
  // MARK: - Properties
  unowned var presenter: OrderDetailsInteractorOutputProtocol
  private let order: Order
  private let imageManager: ImageManagerProtocol = ImageManager()
  
  // MARK: - Initialization
  required init(presenter: OrderDetailsInteractorOutputProtocol, order: Order) {
    self.presenter = presenter
    self.order = order
  }
  
  // MARK: - OrderDetailsInteractorInputProtocol
  func provideOrderImage() {
    if imageManager.cache.isCached(forKey: order.vehicle.photo) {
      presenter.receiveOrderDetailsImageCache(with: order.vehicle.photo)
    } else {
      imageManager.loadImageFromNetwork(with: order.vehicle.photo) { [unowned self] data in
        presenter.receiveOrderDetailsImage(with: OrderDetailsImage(vehicleImage: data))
      } failure: { [unowned self] error in
        presenter.didReceiveError(with: error.errorLightDescription ?? "Unknown error")
      }
    }
  }
  func provideOrderDetails() {
    let formatter = DateFormatter()
    formatter.dateFormat = "d.MM.yy HH:mm"
    let orderDetailsData = OrderDetailsData(
      orderTime: formatter.string(from: order.orderTime),
      modelName: order.vehicle.modelName,
      regNumber: order.vehicle.regNumber,
      driverName: order.vehicle.driverName)
    presenter.receiveOrderDetails(with: orderDetailsData)
  }
}
