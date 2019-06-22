import XCTest
@testable import Astro

class SearchBarMethodsTests: XCTestCase {
    
    let searchBarMethods = SearchBarMethods()
    
    //resetSearchBar
    func testResetSearchBar() {
        let searchBar = UISearchBar()
        searchBar.text = "Testy McTesterson"
        let newSearchbar = searchBarMethods.resetSearchBar(searchBar)
        XCTAssertTrue(newSearchbar.text == "", "Should return a search bar with an emtpy text feild")
    }

}
