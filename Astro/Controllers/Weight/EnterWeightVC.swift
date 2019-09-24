import UIKit

class EnterWeightVC: UIViewController {
    @IBOutlet weak var enterWeightBar: UISearchBar!
    @IBOutlet weak var message: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.enterWeightBar.delegate = self

        KeyboardMethods().setView(view)
        view.addGestureRecognizer(KeyboardMethods().tapAnywhereToHideKeyboard())
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        enterWeightBar = SearchBarMethods().resetSearchBar(enterWeightBar)
        message = LabelMethods().attemptToUpdateLabel(message, withText: "Enter Your Weight", shouldUpdate: true)
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
        message = LabelMethods().attemptToUpdateLabel(message, withText: "Enter a number", shouldUpdate: !isValid)
        NavigationMethods().attemptSegue(SendingVC: self, ID: "goToPlanetWeightScreen", shouldSegue: isValid)
    }

}
