import Foundation
import SVProgressHUD

class NasaDataHandler {
    
    func loadDataWhenViewIsShowing(_ view: UIView, updateViewMethod: () -> Void) {
        if view.isHidden == false {
            updateViewMethod()
            SVProgressHUD.dismiss()
        }
    }
    
    func isDataFinishedLoading(indicator: UIImage?, updateViewMethod: () -> Void) {
        if indicator == nil {
            SVProgressHUD.show()
        } else {
            updateViewMethod()
        }
    }
    
}
