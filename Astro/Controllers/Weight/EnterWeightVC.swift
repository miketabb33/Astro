import UIKit
import RealmSwift

class EnterWeightVC: UIViewController {
    @IBOutlet weak var enterWeightBar: UISearchBar!
    @IBOutlet weak var message: UILabel!
    
    let keyboardMethods = KeyboardMethods()
    let searchBarMethods = SearchBarMethods()
    let navigationMethods = NavigationMethods()
    let labelMethods = LabelMethods()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.enterWeightBar.delegate = self

        keyboardMethods.setView(view)
        view.addGestureRecognizer(keyboardMethods.tapAnywhereToHideKeyboard())
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        enterWeightBar = searchBarMethods.resetSearchBar(enterWeightBar)
        message = labelMethods.attemptToUpdateLabel(message, withText: "Enter Your Weight", shouldUpdate: true)
    }
    
    //MARK - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationNavigationController = segue.destination as! UINavigationController
        let targetController = destinationNavigationController.viewControllers.first as! WeightDisplayTVC
        
        targetController.enteredWeight = Double(enterWeightBar.text!)
    }
    
}

extension EnterWeightVC: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        let isValid = Double(enterWeightBar.text!) != nil
        message = labelMethods.attemptToUpdateLabel(message, withText: "Enter a number", shouldUpdate: !isValid)
        navigationMethods.attemptSegue(SendingVC: self, ID: "goToPlanetWeightScreen", shouldSegue: isValid)
    }

}
