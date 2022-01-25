//
//  KingfisherError.swift
//  RoxieTestTask
//
//  Created by Евгений Карпов on 25.01.2022.
//

import Foundation
import Kingfisher

extension KingfisherError {
  var errorLightDescription: String? {
    switch self {
    case .requestError:
      return "The error during networking request phase"
    case .responseError:
      return "The error during networking response phase"
    case .cacheError:
      return "The error during Kingfisher caching system"
    case .processorError:
      return "The error during image processing phase"
    case .imageSettingError:
      return "The error during image setting in a view related class"
    }
  }
}
