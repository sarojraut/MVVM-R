//
//  NSLayoutConstraint+Helpers.swift
//  SwiftBaseProject
//
//  Created by Mauricio Cousillas on 12/20/18.
//  Copyright © 2018 Mauricio Cousillas. All rights reserved.
//

import Foundation
import UIKit

/**
 NSLayoutConstraints extension to provide helper methods to handle NSLayoutConstraints programatically.
 All functions return self to provide function chaining.
*/
public extension NSLayoutConstraint {
  // Activates the constraint
  public func activate() -> NSLayoutConstraint {
    self.isActive = true
    return self
  }
  // Deactivates the constraint
  public func deactivate() -> NSLayoutConstraint {
    self.isActive = false
    return self
  }
}
