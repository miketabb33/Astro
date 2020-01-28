import XCTest
@testable import Astro

class DecoderMethodsTests: XCTestCase {
    
    let decoderMethods = DecoderMethods()
    
    func test_decodeWithUTF8() {
        let text = "&quot&#229 is &gt then &#1048&#39s &amp &#x6C34&quot"
        
        let result = decoderMethods.decodeWithUTF8(string: text)
        
        print(result)
        
        XCTAssert(result == "\"å is > then И's & 水\"", "The method should turn HTML numbers to utf 8 charactors.")
    }    
}

