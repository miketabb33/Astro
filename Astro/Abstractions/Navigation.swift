import UIKit

class Navigation {
    func attemptSegue(_ bool: Bool, SendingVC: UIViewController) {
        if bool {
            SendingVC.performSegue(withIdentifier: "goToPlanetWeightScreen", sender: self)
        }
    }
}
