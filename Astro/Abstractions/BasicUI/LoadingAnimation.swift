import Foundation
import SVProgressHUD

class LoadingAnimation {
    func show() {
        SVProgressHUD.show()
    }
    
    func hide() {
        SVProgressHUD.dismiss()
    }
}
