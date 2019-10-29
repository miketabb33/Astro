import UIKit

class LabelMethods {
    
    
    func updateLabel(userInput: String?, withText text: String) -> String {
        if Double(userInput!) == nil {
            return text
        }
        return "Enter Your Weight"
    }
}
