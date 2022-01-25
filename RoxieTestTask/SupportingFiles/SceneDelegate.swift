//
//  SceneDelegate.swift
//  RoxieTestTask
//
//  Created by Евгений Карпов on 20.01.2022.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

  var window: UIWindow?

  func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
    guard let windowScene = (scene as? UIWindowScene) else { return }
    window = UIWindow(frame: windowScene.coordinateSpace.bounds)
    window?.windowScene = windowScene
    let navigationController = UINavigationController(rootViewController: OrderListViewController())
    window?.rootViewController = navigationController
    window?.makeKeyAndVisible()
  }
}

