import UIKit

class EnterWeightVC: UIViewController {
    
    @IBOutlet weak var enterWeightBar: UISearchBar!
    @IBOutlet weak var message: UILabel!
    
    let keyboardMethods = KeyboardMethods()
    let searchBarMethods = SearchBarMethods()
    let navigationMethods = NavigationMethods()
    
    var planetsContainer = [Planets]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.enterWeightBar.delegate = self

        keyboardMethods.setView(view)
        view.addGestureRecognizer(keyboardMethods.tapAnywhereToHideKeyboard())
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        searchBarMethods.resetDisplay(searchBar: enterWeightBar, label: message)
    }
    
    //MARK - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationNavigationController = segue.destination as! UINavigationController
        let targetController = destinationNavigationController.viewControllers.first as! WeightDisplayTVC
        
        targetController.enteredWeight = Double(enterWeightBar.text!)
        targetController.planetsContainer = planetsContainer
    }
    
}

extension EnterWeightVC: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        let isValid = searchBarMethods.isValidChecker(enteredText: enterWeightBar.text!, label: message)
        navigationMethods.attemptSegue(isValid, SendingVC: self, ID: "goToPlanetWeightScreen")
    }

}
