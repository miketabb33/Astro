import UIKit

class EnterWeightVC: UIViewController {
    
    @IBOutlet weak var enterWeightBar: UISearchBar!
    @IBOutlet weak var message: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.enterWeightBar.delegate = self
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        enterWeightBar.text = ""
        message.text = "Enter Your Weight"
    }
    
    //MARK - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationNavigationController = segue.destination as! UINavigationController
        let targetController = destinationNavigationController.viewControllers.first as! WeightDisplayTVC
        
        targetController.enteredWeight = Int(enterWeightBar.text!)
    }
}

extension EnterWeightVC: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        performAction()
    }
    
    func performAction(){
        if Int(enterWeightBar.text!) != nil {
            performSegue(withIdentifier: "goToPlanetWeightScreen", sender: self)
        } else {
            message.text = "Enter a number"
        }
    }
}
