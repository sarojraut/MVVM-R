//
//  Routing.swift
//  SwiftBaseProject
//
//  Created by Mauricio Cousillas on 4/4/18.
//  Copyright © 2018 Mauricio Cousillas. All rights reserved.
//

import Foundation
import UIKit

/**
 The base router class implements the router protocol
 exposing basic behaviour extensible via inheritance.

 For example, you should subclass if you want to add
 some logic to the initial route by checking something
 stored in your keychain.
*/
public class BaseRouter: Router {
  public var rootViewController: UINavigationController?
  public var currentViewController: UIViewController?

  public required init(with route: Route) {
    let screen = route.screen
    if let navigation = screen as? UINavigationController {
      rootViewController = navigation
    } else {
      let viewController = screen
      rootViewController = UINavigationController(rootViewController: viewController)
      rootViewController?.isNavigationBarHidden = true
      currentViewController = viewController
    }
  }
}

/**
 The Router is the base of this framework, it handles all
 your application navigation stack.

 It keeps thrack of your root NavigationController and the
 ViewController that is currently displayed. This way it can
 handle any kind of navigation action that you might want to dispatch.
*/
public protocol Router: class {
  /// The root navigation controller of your stack.
  var rootViewController: UINavigationController? { get set }

  /// The currently visible ViewController
  var currentViewController: UIViewController? { get set }

  /// Convencience init to set your application starting screen.
  init(with route: Route)

  /**
   Navigate from your current screen to a new route.

   - Parameters:
      - route: The destination route of your navigation action.
      - transition: The transition type that you want to use.
      - animated: Animate the transition or not.
      - completion: Completion handler.
  */
  func navigate(to route: Route, with transition: TransitionType, animated: Bool, completion: (() -> Void)?)

  /**
   Navigate from your current screen to a new entire router. Can only push a router as a modal. Afterwards, other controllers can be pushed inside the presented Router.

   - Parameters:
   - Router: The destination router that you want to navigate to
   - animated: Animate the transition or not.
   - completion: Completion handler.
   */
  func navigate(to router: Router, animated: Bool, completion: (() -> Void)?)

  /**
   Handles backwards navigation through the stack.

   - Parameters:
       - route: The destination route of your navigation action, pass nil if you want to pop just to the previous controller.
       - animated: Animate the transition or not.
  */
  func popTo(index: Int, animated: Bool)

  /**
   Dismiss your current ViewController.

   - Parameters:
      - animated: Animate the transition or not.
      - completion: Completion handler.
  */
  func dismiss(animated: Bool, completion: (() -> Void)?)
}

public extension Router {
  public func navigate(to route: Route, with transition: TransitionType, animated: Bool = true, completion: (() -> Void)? = nil) {
    let viewController = route.screen
    switch transition {
    case .modal:
      currentViewController?.present(viewController, animated: animated, completion: completion)
      currentViewController = viewController
    case .push:
      rootViewController?.pushViewController(viewController, animated: animated)
      currentViewController = viewController
    case .reset:
      rootViewController?.setViewControllers([viewController], animated: animated)
      currentViewController = viewController
    case .changeRoot:
      UIView.animate(withDuration: 0.3) { [weak self] in
        if let navigation = (viewController as? UINavigationController) {
          UIApplication.shared.keyWindow?.rootViewController = navigation
          self?.rootViewController = navigation
          self?.currentViewController = self?.rootViewController?.topViewController
        } else {
          let navigationController = UINavigationController(rootViewController: viewController)
          UIApplication.shared.keyWindow?.rootViewController = navigationController
          self?.rootViewController = navigationController
          self?.rootViewController?.isNavigationBarHidden = true
          self?.currentViewController = viewController
        }
      }
    }
  }

  func navigate(to router: Router, animated: Bool, completion: (() -> Void)?) {
    guard let viewController = router.rootViewController else {
      assert(false, "Router does not have a root view controller")
      return
    }

    currentViewController?.present(viewController, animated: animated, completion: completion)
    currentViewController = viewController
  }

  public func popToRoot(animated: Bool = true) {
    rootViewController?.popToRootViewController(animated: animated)
  }

  public func popTo(index: Int, animated: Bool = true) {
    guard
      let viewControllers = rootViewController?.viewControllers,
      viewControllers.count > index
    else { return }
    let viewController = viewControllers[index]
    rootViewController?.popToViewController(viewController, animated: animated)
    currentViewController = viewController
  }

  public func dismiss(animated: Bool = true, completion: (() -> Void)? = nil) {
    let presentingViewController = currentViewController?.presentingViewController
    currentViewController?.dismiss(animated: animated, completion: completion)
    currentViewController = presentingViewController
  }
}

/**
 Protocol used to define a set a Route. The route contains
 all the information necessary to instantiate it's screen.

 For example, you could have a LoginRoute, that knows how
 to instantiate it's viewModel, and also forward any
 information that it's passed to the Route.
*/
public protocol Route {
  // The screen that should be returned for that Route.
  var screen: UIViewController { get }
}

/// Available Transition types for navigation actions.
public enum TransitionType {
  /// Presents the screen modally on top of the current ViewController
  case modal

  /// Pushes the next screen to the rootViewController navigation Stack.
  case push

  /// Resets the rootViewController navitationStack and set's the Route's screen as the initial view controller of the stack.
  case reset

  /// Replaces the key window's Root view controller with the Route's screen.
  case changeRoot
}
