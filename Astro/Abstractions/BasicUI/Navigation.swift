import UIKit

class Navigation {
    func segueUnlessNil(SendingVC: UIViewController, segueID: String, data: Any?) {
        if data != nil {
            SendingVC.performSegue(withIdentifier: segueID, sender: self)
        }
    }
}
