import UIKit

class EnterWeightVC: UIViewController {
    
    @IBOutlet weak var enterWeightBar: UISearchBar!
    @IBOutlet weak var message: UILabel!
    
    var planetsContainer = [Planets]()
    let keyboard = Keyboard()
    let enterWeight = EnterWeight()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.enterWeightBar.delegate = self

        keyboard.setView(view)
        view.addGestureRecognizer(keyboard.tapAnywhereToHideKeyboard())
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        enterWeight.resetDisplay(searchBar: enterWeightBar, label: message)
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
        let isValid = enterWeight.isValidChecker(enteredText: enterWeightBar.text!, label: message)
        enterWeight.attemptSegue(isValid, SendingVC: self)
    }

}
