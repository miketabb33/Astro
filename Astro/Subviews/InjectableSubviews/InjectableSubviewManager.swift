import UIKit

class InjectableSubviewManager {
    func instantiateSubview(storyBoardID: String) -> UIViewController {
        let storyboard = UIStoryboard(name: storyBoardID, bundle: nil)
        let componentVC = storyboard.instantiateViewController(withIdentifier: storyBoardID)
        return componentVC
    }
    
    func injectSubviewIntoParent(subviewVC: UIViewController, parentVC: UIViewController) {
        parentVC.view.addSubview(subviewVC.view)
        parentVC.addChild(subviewVC)
    }
    
    func removeSubviewFromParent(subviewVC: UIViewController) {
        subviewVC.removeFromParent()
        subviewVC.view.removeFromSuperview()
    }

}
