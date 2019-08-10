import Foundation
import SVProgressHUD

class LoadingAnimation {
    var loadingIcon = UIActivityIndicatorView()
    
    func show() {
        SVProgressHUD.show()
    }
    
    func hide() {
        SVProgressHUD.dismiss()
    }
    
    func addLoadingNextCellAnimation(parentView: UIView) {
        loadingIcon.center = CGPoint(x: UIScreen.main.bounds.width/2, y: UIScreen.main.bounds.height - 65)
        loadingIcon.color = UIColor.black
        loadingIcon.startAnimating()
        parentView.addSubview(loadingIcon)
    }
    
    func removeLoadingNextCellAnimation() {
        loadingIcon.removeFromSuperview()
    }
}
