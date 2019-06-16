import UIKit

class NasaDataHandler {
    let loadingAnimation = LoadingAnimation()
    
    func loadDataWhenViewIsShowing(_ view: UIView, updateViewMethod: () -> Void) {
        if view.isHidden == false {
            updateViewMethod()
            loadingAnimation.hide()
        }
    }
    
    func isDataFinishedLoading(indicator: UIImage?, updateViewMethod: () -> Void) {
        if indicator == nil {
            loadingAnimation.show()
        } else {
            updateViewMethod()
        }
    }
    
}
