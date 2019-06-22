import XCTest
@testable import Astro

class MathMethodsTests: XCTestCase {
    
    let mathMethods = MathMethods()
    
    //findRelativeEnteredWeightInlbs
    func testFindRelativeEnteredWeightInlbs() {
        let relativeWeight : Decimal = 3.0
        let enteredWeight : Double = 100.3
        let value = mathMethods.findRelativeEnteredWeightInlbs(relativeWeight: relativeWeight, enteredWeight: enteredWeight)
        XCTAssertTrue(value == 300.9, "Should return enteredWeight * elativeWeight")
    }
    
}
