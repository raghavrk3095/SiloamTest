//
//  Siloam_TestTests.swift
//  Siloam TestTests
//
//  Created by Apple on 11/08/23.
//

import XCTest

@testable import Siloam_Test

class Siloam_TestTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func test_login_button_functionality_with_empty_username() throws {
        let loginModel = LoginViewModel()
        let str = loginModel.checkLoginButtonFunctionality(username: "", password: "abc")
        XCTAssertEqual(CommonStrings.emptyUname, str)
    }
    
    func test_login_button_functionality_with_empty_password() throws {
        let loginModel = LoginViewModel()
        let str = loginModel.checkLoginButtonFunctionality(username: "abc", password: "")
        XCTAssertEqual(CommonStrings.emptyPass, str)
    }
}
