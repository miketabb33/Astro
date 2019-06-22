import XCTest
@testable import Astro

class FormatterMethodsTests: XCTestCase {
    
    let formatterMethods = FormatterMethods()
    
    //formatWeightlbs
    func testFormatWeightAslbsManyPlaceValues() {
        let weight : Decimal = 50.03123
        let value = formatterMethods.formatWeight(weight)
        XCTAssertTrue(value == "50.03 lbs", "Should return 2 place values when many exist")
    }
    
    func testFormatWeightAslbsNoPlaceValues() {
        let weight : Decimal = 50
        let value = formatterMethods.formatWeight(weight)
        print(value)
        XCTAssertTrue(value == "50 lbs", "Should return 0 place values when none exist")
    }
    
    func testFormatWeightAslbs1PlaceValue() {
        let weight : Decimal = 50.6
        let value = formatterMethods.formatWeight(weight)
        print(value)
        XCTAssertTrue(value == "50.6 lbs", "Should return 0 place values when none exist")
    }
    
}
