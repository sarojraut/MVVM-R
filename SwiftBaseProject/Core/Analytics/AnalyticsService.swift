//
//  AnalyticsManager.swift
//  SwiftBaseProject
//
//  Created by Mauricio Cousillas on 12/13/18.
//  Copyright © 2018 Mauricio Cousillas. All rights reserved.
//

import Foundation

public struct AnalyticsEvent {
  let name: String
  let attributes: [String: Any]
}

public protocol AnalyticsService {
  func log(event: AnalyticsEvent)

  func authenticate(with id: String, email: String, name: String)
}

public protocol AnalyticsManagerProtocol: AnalyticsService {
  init(with: [AnalyticsService])
}
