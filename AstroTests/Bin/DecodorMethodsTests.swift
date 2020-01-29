import XCTest
@testable import Astro

class DecoderMethodsTests: XCTestCase {
    
    func test_decodeWithUTF8() {
        let text = "&quot&#229 is &gt then &#1048&#39s &amp &#x6C34&quot"
        
        let result = String.decodeHTMLSymbols(string: text)
        
        XCTAssert(result == "\"å is > then И's & 水\"", "The method should turn HTML numbers to utf 8 charactors.")
    }    
}

