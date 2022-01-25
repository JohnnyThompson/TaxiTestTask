//
//  OrderDetailsConfigurator.swift
//  RoxieTestTask
//
//  Created by Евгений Карпов on 20.01.2022.
//

import Foundation

protocol OrderDetailsConfiguratorInputProtocol {
  func configure(with viewController: OrderDetailsViewController, and order: Order)
}

class OrderDetailsConfigurator: OrderDetailsConfiguratorInputProtocol {
  func configure(with viewController: OrderDetailsViewController, and order: Order) {
    let presenter = OrderDetailsPresenter(view: viewController)
    let interactor = OrderDetailsInteractor(presenter: presenter, order: order)
    viewController.presenter = presenter
    presenter.interactor = interactor
  }
}
