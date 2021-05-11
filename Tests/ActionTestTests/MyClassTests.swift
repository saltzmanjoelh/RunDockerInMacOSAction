//
//  ActionTest.swift
//
//
//  Created by Joel Saltzman on 1/28/21.
//

import Foundation
import XCTest
import ShellOut

class MyClassTests: XCTestCase {
    func testSomething() throws {
        print(try shellOut(to: "which docker"))
    }
}
