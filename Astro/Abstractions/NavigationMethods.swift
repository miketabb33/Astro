import UIKit

class NavigationMethods {
    func attemptSegue(SendingVC: UIViewController, ID: String, shouldSegue: Bool) {
        if shouldSegue {
            SendingVC.performSegue(withIdentifier: ID, sender: self)
        }
    }
}
