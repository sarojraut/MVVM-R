//
//  SwiftBaseProjectTests.swift
//  SwiftBaseProjectTests
//
//  Created by Mauricio Cousillas on 3/12/18.
//  Copyright © 2018 Mauricio Cousillas. All rights reserved.
//

import XCTest
import Nimble
import SnapshotTesting
@testable import SwiftBaseProject

class SwiftBaseProjectTests: XCTestCase {

  override func setUp() {
    super.setUp()
  }

  override func tearDown() {
    super.tearDown()
  }

  func testLogicExample() {
    let viewModel = DashboardViewModel()
    expect(viewModel.user.value?.username).to(equal("juan"))
  }

  func testViewControllerExample() {
    let vc = HomeRoute.dashboard.screen
    assertSnapshot(matching: vc, as: .image)
  }
  
}
