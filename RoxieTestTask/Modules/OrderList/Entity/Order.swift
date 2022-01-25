//
//  Order.swift
//  RoxieTestTask
//
//  Created by Евгений Карпов on 20.01.2022.
//

import Foundation

typealias Orders = [Order]

struct Order: Codable {
  let id: Int
  let startAddress: Address
  let endAddress: Address
  let price: Price
  let orderTime: Date
  let vehicle: Vehicle
}

struct Address: Codable {
  let city: String
  let address: String
}

struct Price: Codable {
  let amount: Int
  let currency: String
}

struct Vehicle: Codable {
  let regNumber: String
  let modelName: String
  let photo: String
  let driverName: String
}
