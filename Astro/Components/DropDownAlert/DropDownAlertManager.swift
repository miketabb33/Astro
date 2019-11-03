import UIKit

class DropDownAlertManager {
    func addAlertToScreen(parentVC: UIViewController, message: String, backgroundColor: UIColor) {
        
        let dropDownAlertVC = ComponentManager().instantiateComponent(storyBoardID: "DropDownAlert") as! DropDownAlertVC
        
        ComponentManager().insertComponentIntoView(componentVC: dropDownAlertVC, parentVC: parentVC)
        
        dropDownAlertVC.label.text = message
        dropDownAlertVC.view.backgroundColor = backgroundColor
        
        
        dropDownAlertVC.view.translatesAutoresizingMaskIntoConstraints = false
        dropDownAlertVC.view.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width).isActive = true
        var height = dropDownAlertVC.view.heightAnchor.constraint(equalToConstant: 1)
        height.isActive = true
        height.isActive = false
        UIView.animate(withDuration: 5) {
            dropDownAlertVC.view.heightAnchor.constraint(equalToConstant: 60).isActive = true
            dropDownAlertVC.view.layoutIfNeeded()
        }
    }
    
}
