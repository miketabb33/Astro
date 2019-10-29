import UIKit

class RelativeWeightInputVC: UIViewController {
    @IBOutlet weak var enterWeightBar: UISearchBar!
    @IBOutlet weak var message: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        enterWeightBar.delegate = self

        KeyboardMethods().setView(view)
        view.addGestureRecognizer(KeyboardMethods().tapAnywhereToHideKeyboard())
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationNavigationController = segue.destination as! UINavigationController
        let targetController = destinationNavigationController.viewControllers.first as! WeightDisplayTVC
        
        targetController.enteredWeight = Double(enterWeightBar.text!)
    }
    
}

extension RelativeWeightInputVC: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        let isValid = Double(enterWeightBar.text!) != nil
        message.text = LabelMethods().updateLabel(userInput: enterWeightBar.text, withText: "Enter a number")
        NavigationMethods().attemptSegue(SendingVC: self, ID: "goToPlanetWeightScreen", shouldSegue: isValid)
    }

}
