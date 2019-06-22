import UIKit

class NavigationMethods {
    func attemptSegue(_ bool: Bool, SendingVC: UIViewController, ID: String) {
        if bool {
            SendingVC.performSegue(withIdentifier: ID, sender: self)
        }
    }
}
