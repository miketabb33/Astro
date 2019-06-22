import UIKit

class LabelMethods {
    func attemptToUpdateLabel(_ label: UILabel, withText text: String, shouldUpdate: Bool) -> UILabel {
        if shouldUpdate {
            label.text = text
        }
        return label
    }
}
