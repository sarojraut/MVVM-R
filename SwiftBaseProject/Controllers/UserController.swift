//
//  UserController.swift
//  SwiftBaseProject
//
//  Created by Mauricio Cousillas on 3/15/18.
//  Copyright © 2018 Mauricio Cousillas. All rights reserved.
//

import Foundation
import RxSwift

class UserController {

  static let sharedInstance = UserController()
  private let serviceManager = UserServiceManager()
  private let dataAccess = UserDataAccess()
  private var disposeBag = DisposeBag()

  var currentUser: User? {
    return dataAccess.currentUser
  }

  func login(with username: String, password: String) -> Observable<User> {
    guard let user = currentUser else {
      return Observable.error(RxError.noElements)
    }
    return Observable.just(user)
    // We should call serviceCall here, this cache is only to make it work as a mock
//    return serviceCall
//      .do(onNext: { [weak self] user in
//        self?.dataAccess.save(user: user)
//      })
  }

  func logout() -> Observable<Void> {
    dataAccess.deleteCurrentUser()
    return Observable.just(())
  }

}
