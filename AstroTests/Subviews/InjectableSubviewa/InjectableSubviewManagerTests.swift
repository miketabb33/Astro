import XCTest
@testable import Astro

class InjectableSubviewManagerTests: XCTestCase {
    
    func test_instantiateSubview() {
        let dropDownAlertVC = InjectableSubviewManager().instantiateSubview(storyBoardID: "DropDownAlert")
        XCTAssertTrue(dropDownAlertVC is DropDownAlertVC, "Should instantiate the correct controller for the subview")
    }
    
    func test_injectSubviewIntoParent() {
        let parentVC = UIViewController()
        let dropDownAlertVC = InjectableSubviewManager().instantiateSubview(storyBoardID: "DropDownAlert")
        InjectableSubviewManager().injectSubviewIntoParent(subviewVC: dropDownAlertVC, parentVC: parentVC)
        
        XCTAssertTrue(dropDownAlertVC.view.isDescendant(of: parentVC.view), "Should insert the subview into the parent")
    }
    
    func test_removeSubviewFromParent() {
        let parentVC = UIViewController()
        let dropDownAlertVC = InjectableSubviewManager().instantiateSubview(storyBoardID: "DropDownAlert")
        InjectableSubviewManager().injectSubviewIntoParent(subviewVC: dropDownAlertVC, parentVC: parentVC)
        
        InjectableSubviewManager().removeSubviewFromParent(subviewVC: dropDownAlertVC)
        
        XCTAssertFalse(dropDownAlertVC.view.isDescendant(of: parentVC.view), "Should remove the subview from the parent")
    }
    
}
