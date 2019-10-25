//
//  LoginRoutes.swift
//  SwiftBaseProject
//
//  Created by Mauricio Cousillas on 4/4/18.
//  Copyright © 2018 Mauricio Cousillas. All rights reserved.
//

import Foundation
import UIKit

enum LoginRoute: Route {
  case login(username: String?)

  var screen: UIViewController {
    switch self {
    case .login(let username):
      guard let login = R.storyboard.main.instantiateInitialViewController() else {
        return UIViewController()
      }
      login.viewModel = LoginViewModel(with: username)
      return login
    }
  }
}
