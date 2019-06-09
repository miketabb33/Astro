import UIKit

class EnterWeightVC: UIViewController {
    
    @IBOutlet weak var enterWeightBar: UISearchBar!
    @IBOutlet weak var message: UILabel!
    
    var planetsContainer = [Planets]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.enterWeightBar.delegate = self
        
        let hideKeyboardTapGesture = tapAnywhereToHideKeyboard()
        view.addGestureRecognizer(hideKeyboardTapGesture)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        enterWeightBar.text = ""
        message.text = "Enter Your Weight"
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
        performAction()
    }
    
    func performAction(){
        if Double(enterWeightBar.text!) != nil {
            performSegue(withIdentifier: "goToPlanetWeightScreen", sender: self)
        } else {
            message.text = "Enter a number"
        }
    }
    
    func tapAnywhereToHideKeyboard() -> UITapGestureRecognizer {
        return UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
    }
    
    @objc func hideKeyboard() {
        view.endEditing(true)
    }
}
