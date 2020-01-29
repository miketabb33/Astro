import XCTest
@testable import Astro

class FormatterMethodsTests: XCTestCase {
    
    func test_RoundTo2DecimalPlaces_NoDecimals() {
        let double: Double = 50
        let result = FormatterMethods().roundTo2DecimalPlaces(weight: double)
        print(result)
        XCTAssert(result == "50.00", "Method should return a number with 2 decimal places")
    }
    
    func test_RoundTo2DecimalPlaces_00() {
        let double = 100.0000001
        let result = FormatterMethods().roundTo2DecimalPlaces(weight: double)
        print(result)
        XCTAssert(result == "100.00", "Method should return a number with 2 decimal places")
    }
    
    func test_RoundTo2DecimalPlaces_67() {
        let double = 100.669014534356
        let result = FormatterMethods().roundTo2DecimalPlaces(weight: double)
        print(result)
        XCTAssert(result == "100.67", "Method should return a number with 2 decimal places")
    }
    
}
