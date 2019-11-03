import XCTest
@testable import Astro

class SearchBarMethodsTests: XCTestCase {
    
    var searchBar = UISearchBar()
    let pass = "Passing"
    let fail = "Failure"
    
    override func setUp() {
        super.setUp()
        searchBar = UISearchBar()
    }
    
    func test_GetValidationMessageForDouble_pass() {
        searchBar.text = "180"
        let result = SearchBarMethods(searchBar).getValidationMessageForDouble(onSuccess: pass, onFailure: fail)
        XCTAssert(result == pass, "Method should return the on seccuss text when a double is in the searchbar")
    }
    
    func test_GetValidationMessageForDouble_fail() {
        searchBar.text = "Not A Double"
        let result = SearchBarMethods(searchBar).getValidationMessageForDouble(onSuccess: pass, onFailure: fail)
        XCTAssert(result == fail, "Method should return the on failure text when not a double is in the searchbar")
    }

}
