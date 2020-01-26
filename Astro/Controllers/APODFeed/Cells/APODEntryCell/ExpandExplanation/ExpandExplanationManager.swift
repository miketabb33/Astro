import UIKit

class ExpandExplanationManager {
    func toggle(isExpanded: Bool, label: UILabel, button: UIButton) -> CGFloat {
        toggleContentSize(isExpanded: isExpanded, label: label)
        toggleArrowDirection(isExpanded: isExpanded, button: button)
        
        let labelHeight = getNewLabelHeight(isExpanded: isExpanded, label: label)
        
        return labelHeight
    }
    
    
    
    func toggleContentSize(isExpanded: Bool, label: UILabel) {
        if isExpanded {
            ExpandExplanationAnimation().resizeContentsAnimation(label: label, numberOfShowingLines: 7, duration: 0)
        } else {
            ExpandExplanationAnimation().resizeContentsAnimation(label: label, numberOfShowingLines: 0, duration: 0.3)
        }
    }
    
    func getNewLabelHeight(isExpanded: Bool, label: UILabel) -> CGFloat {
        if isExpanded {
            return StaticElementHeights().explanation
        } else {
            return label.frame.height
        }
    }
    
    func toggleArrowDirection(isExpanded: Bool, button: UIButton) {
        if isExpanded {
            ExpandExplanationAnimation().rotateArrowAnimation(button: button, arrowPosition: .identity)
        } else {
            ExpandExplanationAnimation().rotateArrowAnimation(button: button, arrowPosition: CGAffineTransform(rotationAngle: .pi))
        }
    }
}
