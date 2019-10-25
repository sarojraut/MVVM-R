//
//  AnalyticsManager.swift
//  SwiftBaseProject
//
//  Created by Mauricio Cousillas on 12/13/18.
//  Copyright © 2018 Mauricio Cousillas. All rights reserved.
//

import Foundation

public class AnalyticsManager: AnalyticsManagerProtocol {

  var services = [AnalyticsService]()

  required public init(with services: [AnalyticsService]) {
    self.services = services
  }

  public func authenticate(with id: String, email: String, name: String) {
    services.forEach {
      $0.authenticate(with: id, email: email, name: name)
    }
  }

  public func log(event: AnalyticsEvent) {
    services.forEach {
      $0.log(event: event)
    }
  }
}
