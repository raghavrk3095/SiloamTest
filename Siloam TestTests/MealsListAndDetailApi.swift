//
//  MealsListAndDetailApi.swift
//  Siloam TestTests
//
//  Created by Apple on 13/08/23.
//

import XCTest

@testable import Siloam_Test

class MealsListAndDetailApi: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func test_meals_with_one_letter() throws {
        let params: [String: Any] = [
            "f" : "i"
        ]
        let expectations = self.expectation(description: "Fetch meals with first letter")
        
        APIManager.callMealsListApi(apiUrl: APIUrls.baseUrl + APIUrls.searchFirstLetterUrl, params: params, headers: nil) { (response) in
            XCTAssertNotNil(response)
            XCTAssertNil(response.error)
            XCTAssertNotEqual(0, response.value?.meals?.count)
            expectations.fulfill()
        }
        
        waitForExpectations(timeout: 5, handler: nil)
    }
    
    func test_meals_with_no_letter_or_more_letters() throws {
        let params: [String: Any] = [
            "f" : ""
        ]
        let expectations = self.expectation(description: "Return error with no letter or more letters")
        
        APIManager.callMealsListApi(apiUrl: APIUrls.baseUrl + APIUrls.searchFirstLetterUrl, params: params, headers: nil) { response in
            XCTAssertNotNil(response)
            XCTAssertNotNil(response.error)
            expectations.fulfill()
        }
        
        waitForExpectations(timeout: 5, handler: nil)
    }
    
    func test_meal_with_valid_id() throws {
        let params: [String: Any] = [
            "i" : "52772"
        ]
        let expectations = self.expectation(description: "Fetch meal detail with id")
        
        APIManager.callMealDetailApi(apiUrl: APIUrls.baseUrl + APIUrls.mealDetailUrl, params: params, headers: nil) { response in
            XCTAssertNotNil(response)
            XCTAssertNil(response.error)
            XCTAssertEqual("52772", response.value?.meals?[0].mealId)
            expectations.fulfill()
        }
        
        waitForExpectations(timeout: 5, handler: nil)
    }
}
