import UIKit

class DropDownAlertManager {
    let alertHeight: CGFloat = 50
    let animationDuration: Double = 0.25
    
    func createAndAddAlertToScreen(parentVC: UIViewController, message: String, backgroundColor: UIColor) -> DropDownAlertVC {
        
        let dropDownAlertVC = ComponentManager().instantiateComponent(storyBoardID: "DropDownAlert") as! DropDownAlertVC
        
        ComponentManager().insertComponentIntoView(componentVC: dropDownAlertVC, parentVC: parentVC)
        
        dropDownAlertVC.label.text = message

        dropDownAlertVC.backgroundColor = backgroundColor

        configureWidthAndHeightOfAlert(alertVC: dropDownAlertVC)
        setInitialPositionOfAlert(alertVC: dropDownAlertVC)
        animateAlertIntoView(alertVC: dropDownAlertVC)
        
        return dropDownAlertVC

    }
    
    func removeAlertFromScreen(alertVC: DropDownAlertVC?) -> DropDownAlertVC? {
        if let VC = alertVC {
            UIView.animate(withDuration: animationDuration, animations: {
                VC.view.transform = CGAffineTransform(translationX: 0, y: 0 - self.alertHeight)
            }) { (finished) in
                ComponentManager().removeComponentFromView(componentVC: VC)
            }
        }
        return nil
    }
    
    
    
    func configureWidthAndHeightOfAlert(alertVC: DropDownAlertVC) {
        alertVC.view.translatesAutoresizingMaskIntoConstraints = false
        let widthFullScreen = alertVC.view.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width)
        let height = alertVC.view.heightAnchor.constraint(equalToConstant: alertHeight)
        
        widthFullScreen.isActive = true
        height.isActive = true
    }
    
    func animateAlertIntoView(alertVC: DropDownAlertVC) {
        UIView.animate(withDuration: animationDuration) {
            alertVC.view.transform = CGAffineTransform(translationX: 0, y: UIApplication.shared.windows[0].safeAreaInsets.top)
        }
    }
    
    func setInitialPositionOfAlert(alertVC: DropDownAlertVC) {
        alertVC.view.transform = CGAffineTransform(translationX: 0, y: 0 - alertHeight)
    }
}
