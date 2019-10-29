import UIKit

class RelativeWeightInputVC: UIViewController {
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var label: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self

        view.addGestureRecognizer(KeyboardMethods(view: view).tapAnywhereToHideKeyboard())
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationNavigationController = segue.destination as! UINavigationController
        let targetController = destinationNavigationController.viewControllers.first as! WeightDisplayTVC
        
        targetController.enteredWeight = Double(searchBar.text!)
    }
    
}

extension RelativeWeightInputVC: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        label.text = SearchBarValidation(searchBar: searchBar).validateDouble(onSuccess: "Enter Your Weight", onFailure: "Enter a number")
        Navigation().segueUnlessNil(SendingVC: self, segueID: "goToPlanetWeightScreen", data: Double(searchBar.text!))
    }

}
