//
//  NetworkManager.swift
//  RoxieTestTask
//
//  Created by Евгений Карпов on 20.01.2022.
//

import Foundation

protocol NetworkManagerProtocol {
  func getOrdersList(completion: @escaping (Result<Orders, Error>) -> Void)
}

class NetworkManager: NetworkManagerProtocol {
  // MARK: - Properties
  static let shared = NetworkManager()
  
  // MARK: - Public functions
  public func getOrdersList(completion: @escaping (Result<Orders, Error>) -> Void) {
    let path = "https://www.roxiemobile.ru/careers/test/orders.json"
    request(path: path) { (result: Result<Orders, Error>) in
      switch result {
      case .success(var data):
        data.sort {
          $0.orderTime > $1.orderTime
        }
        completion(.success(data))
      case .failure(let error):
        completion(.failure(error))
        print(error.localizedDescription)
      }
    }
  }
  
  // MARK: - Module functions
  private func request<T: Decodable>(path: String,
                                     completion: @escaping (Result<T, Error>) -> Void) {
    guard let url = URL(string: path) else {
      return
    }
    let task = URLSession.shared.dataTask(with: url) { data, _, error in
      guard let data = data else {
        if let error = error {
          DispatchQueue.main.async {
            completion(.failure(NetworkError.serverError(error: error)))
          }
          return
        }
        DispatchQueue.main.async {
          completion(.failure(NetworkError.noConnectionError))
        }
        return
      }
      let decoder = JSONDecoder()
      decoder.dateDecodingStrategy = .iso8601
      do {
        let result = try decoder.decode(T.self, from: data)
        DispatchQueue.main.async {
          completion(.success(result))
        }
      } catch {
        DispatchQueue.main.async {
          completion(.failure(NetworkError.incorrectDataError))
        }
      }
    }
    task.resume()
  }
}


