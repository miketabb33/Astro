import UIKit

class KeyboardMethods {
    var view : UIView
    
    init(view: UIView) {
        self.view = view
    }
    
    func tapAnywhereToHideKeyboard() -> UITapGestureRecognizer {
        return UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
    }
    
    @objc func hideKeyboard() {
        view.endEditing(true)
    }
}
