import UIKit

class Keyboard {
    var view : UIView?
    
    func setView(_ view: UIView) {
        self.view = view
    }
    
    func tapAnywhereToHideKeyboard() -> UITapGestureRecognizer {
        return UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
    }
    
    @objc func hideKeyboard() {
        view!.endEditing(true)
    }
}
