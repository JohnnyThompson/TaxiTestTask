//
//  ImageManager.swift
//  RoxieTestTask
//
//  Created by Евгений Карпов on 20.01.2022.
//

import Foundation
import Kingfisher

protocol ImageManagerProtocol {
  var cache: ImageCache { get }
  var lifeTime: Double { get set }
  func loadImageFromNetwork(with cacheKey: String,
                            success: @escaping (Data) -> (),
                            failure: @escaping (KingfisherError) -> ())
  func loadImageFromCache(with cacheKey: String,
                          success: @escaping (KFCrossPlatformImage?) -> (),
                          failure: @escaping (KingfisherError) -> ())
}

class ImageManager: ImageManagerProtocol {
  // MARK: - Properties
  private var url = "https://www.roxiemobile.ru/careers/test/images/"
  let cache = ImageCache(name: "imageCache")
  var lifeTime: Double = 600
  
  // MARK: - Public functions
  public func loadImageFromNetwork(with cacheKey: String,
                                   success: @escaping (Data) -> (),
                                   failure: @escaping (KingfisherError) -> ()) {
    guard let url = URL(string: "\(url)\(cacheKey)") else {
      return
    }
    ImageDownloader.default.downloadImage(with: url) { [unowned self] result in
      switch result {
      case .success(let value):
        print("Картинка \(cacheKey) загружен: из сети")
        cache.store(value.image, original: value.originalData, forKey: cacheKey, options: KingfisherParsedOptionsInfo([ .diskCacheExpiration(.seconds(lifeTime)), .memoryCacheExpiration(.seconds(lifeTime))]), toDisk: true)
        success(value.originalData)
      case .failure(let error):
        failure(error)
      }
    }
  }
  
  public func loadImageFromCache(with cacheKey: String,
                                 success: @escaping (KFCrossPlatformImage?) -> (),
                                 failure: @escaping (KingfisherError) -> ()) {
    cache.retrieveImage(forKey: cacheKey) { result in
      switch result {
      case .success(let value):
        print("Картинка \(cacheKey) загружена из кеша")
        success(value.image)
      case .failure(let error):
        failure(error)
      }
    }
  }
}


