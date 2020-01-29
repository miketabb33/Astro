import UIKit

extension UIColor {
    static func getAppropriateTextColorFor(backgroundColor: UIColor) -> UIColor {
        if backgroundColor.rgba.red < 0.35 || backgroundColor.rgba.blue < 0.35 || backgroundColor.rgba.green < 0.35 {
            return UIColor.white
        } else {
            return UIColor.black
        }
    }
    
    static func primary(alpha: CGFloat) -> UIColor {
        return UIColor(red: 2.0/255.0, green: 117.0/255.0, blue: 216.0/255.0, alpha: alpha)
    }
    
    static func success(alpha: CGFloat) -> UIColor {
        return UIColor(red: 92.0/255.0, green: 184.0/255.0, blue: 92.0/255.0, alpha: alpha)
    }
    
    static func info(alpha: CGFloat) -> UIColor {
        return UIColor(red: 91.0/255.0, green: 192.0/255.0, blue: 222.0/255.0, alpha: alpha)
    }

    static func warning(alpha: CGFloat) -> UIColor {
        return UIColor(red: 240.0/255.0, green: 173.0/255.0, blue: 78.0/255.0, alpha: alpha)
    }
    
    static func danger(alpha: CGFloat) -> UIColor {
        return UIColor(red: 217.0/255.0, green: 83.0/255.0, blue: 79.0/255.0, alpha: alpha)
    }
    
    static func inverse(alpha: CGFloat) -> UIColor {
        return UIColor(red: 41.0/255.0, green: 43.0/255.0, blue: 44.0/255.0, alpha: alpha)
    }
    
    static func faded(alpha: CGFloat) -> UIColor {
        return UIColor(red: 247.0/255.0, green: 247.0/255.0, blue: 247.0/255.0, alpha: alpha)
    }
}