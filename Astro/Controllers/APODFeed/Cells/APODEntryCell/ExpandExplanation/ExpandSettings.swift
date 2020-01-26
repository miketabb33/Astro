import UIKit

class ExpandSettings {
    let arrowDefault: CGAffineTransform = .identity
    let arrowIsExpanded = CGAffineTransform(rotationAngle: .pi)
    
    let numberOfLinesDefault = 7
    let numberOfLinesIsExpanded = 0
    
    func show(isExpanded: Bool, label: UILabel, button: UIButton) {
        if isExpanded {
            label.numberOfLines = numberOfLinesIsExpanded
            button.transform = arrowIsExpanded
        } else {
            label.numberOfLines = numberOfLinesDefault
            button.transform = arrowDefault
        }
    }
}
