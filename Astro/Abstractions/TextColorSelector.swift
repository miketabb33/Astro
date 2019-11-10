import UIKit

class TextColorSelector {
    func getTextColor(backgroundColor: UIColor) -> UIColor {
        print(backgroundColor.rgba)
        if backgroundColor.rgba.red < 0.35 || backgroundColor.rgba.blue < 0.35 || backgroundColor.rgba.green < 0.35 {
            return UIColor.white
        } else {
            return UIColor.black
        }
    }
}
