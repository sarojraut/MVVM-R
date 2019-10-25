//
//  Logger.swift
//  SwiftBaseProject
//
//  Created by Mauricio Cousillas on 12/13/18.
//  Copyright © 2018 Mauricio Cousillas. All rights reserved.
//

import Foundation
import os

/**
 Public protocol that defines the behaviour of a logger service.
*/
public protocol Logger {
  // The main instance of the Logger.
  static var sharedInstance: Self { get }
  // Logs an specific error.
  func log(error: Error)
  // Logs a message and it's payload.
  func log(message: String, with values: [Any])
}

/**
 Basic implementation of a logger.
 Logs to the console by default, it could be extended
 or replaced with a new implementation of the logger
 protocol using crashlytics for example
*/
public struct BaseLogger: Logger {
  public static let sharedInstance = BaseLogger()
  // Prints the string representation of the error.
  public func log(error: Error) {
    debugPrint(error)
  }
  // Prints the message string and it's values as a dash separated string.
  public func log(message: String, with values: [Any]) {
    debugPrint(message)
    debugPrint(values, separator: "-", terminator: ";")
  }
}
