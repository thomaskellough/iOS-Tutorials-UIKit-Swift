//
//  How_To_Use_Unit_TestingTests.swift
//  How-To-Use-Unit-TestingTests
//
//  Created by Thomas Kellough on 11/7/20.
//

import XCTest
@testable import How_To_Use_Unit_Testing

class How_To_Use_Unit_TestingTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testFirstNameHarryIsValid_True() {
        let name = "Harry"
        let isValid = name.isValidFirstName
        XCTAssertTrue(isValid, "Uh oh! \(name) is not valid")
    }
    
    func testFirstNamehermioneIsValid_True() {
        let name = "hermione"
        let isValid = name.isValidFirstName
        XCTAssertTrue(isValid, "Uh oh! \(name) is not valid")
    }
    
    func testFirstNameRon5IsValid_False() {
        let name = "Ron5"
        let isValid = name.isValidFirstName
        XCTAssertFalse(isValid, "Uh oh! \(name) is not valid")
    }
    
    func testLastNamePotterIsValid_True() {
        let name = "Potter"
        let isValid = name.isValidLastName
        XCTAssertTrue(isValid)
    }
    
    func testDobIsValid1_True() {
        let dob = "01/01/1980"
        let isValid = dob.isValidDOB
        XCTAssertTrue(isValid)
    }
    
    func testDobIsValid1_False() {
        let dob = "01/01/80"
        let isValid = dob.isValidDOB
        XCTAssertFalse(isValid)
    }
    
    func test1234IsValid_True() {
        let pin = "1234"
        let isValid = pin.isValidPin
        XCTAssertTrue(isValid)
    }
    
    func test12345IsValid_False() {
        let pin = "12345"
        let isValid = pin.isValidPin
        XCTAssertFalse(isValid)
    }
    
    func testa234ISValid_False() {
        let pin = "a234"
        let isValid = pin.isValidPin
        XCTAssertFalse(isValid)
    }

}
