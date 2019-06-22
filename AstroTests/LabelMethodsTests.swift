import XCTest
@testable import Astro

class LabelMethodsTests: XCTestCase {
    
    let labelMethods = LabelMethods()
    
    //resetSearchBar
    func testAttemptToUpdateLabelTrue() {
        let label = UILabel()
        label.text = "Foo Bar"
        let newLabel = labelMethods.attemptToUpdateLabel(label, withText: "Success", shouldUpdate: true)
        XCTAssertTrue(newLabel.text == "Success", "Should return a label with updated text when shouldUpdate is true")
    }
    
    func testAttemptToUpdateLabelFalse() {
        let label = UILabel()
        label.text = "Foo Bar"
        let newLabel = labelMethods.attemptToUpdateLabel(label, withText: "Success", shouldUpdate: false)
        XCTAssertTrue(newLabel.text == "Foo Bar", "Should return a label with updated text when shouldUpdate is false")
    }
    
}


