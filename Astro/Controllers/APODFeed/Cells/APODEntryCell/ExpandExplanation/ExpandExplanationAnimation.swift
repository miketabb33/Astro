import UIKit

class ExpandExplanationAnimation {
    func resizeContentsAnimation(label: UILabel, numberOfShowingLines: Int, duration: Double) {
        UIView.transition(with: label, duration: duration, options: [.curveLinear], animations: {
            label.numberOfLines = numberOfShowingLines
            label.sizeToFit()
        })
    }

    func rotateArrowAnimation(button: UIButton, arrowPosition: CGAffineTransform) {
        UIView.animate(withDuration: 0.3) {
            button.transform = arrowPosition
        }
    }
}


