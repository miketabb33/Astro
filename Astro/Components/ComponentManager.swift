import UIKit

class ComponentManager {
    func instantiateComponent(storyBoardID: String) -> UIViewController {
        let storyboard = UIStoryboard(name: storyBoardID, bundle: nil)
        let componentVC = storyboard.instantiateViewController(withIdentifier: storyBoardID)
        return componentVC
    }
    
    func insertComponentIntoView(componentVC: UIViewController, parentVC: UIViewController) {
        parentVC.view.addSubview(componentVC.view)
        parentVC.addChild(componentVC)
    }
    
    func removeComponentFromView(componentVC: UIViewController) {
        componentVC.removeFromParent()
        componentVC.view.removeFromSuperview()
    }

}
