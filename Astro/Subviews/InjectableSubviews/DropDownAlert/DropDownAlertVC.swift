import UIKit

class DropDownAlertVC: UIViewController {
    
    @IBOutlet weak var label: UILabel!
    
    var backgroundColor: UIColor?
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func viewDidAppear(_ animated: Bool) {
        view.backgroundColor = backgroundColor
        label.textColor = UIColor.getAppropriateTextColorFor(backgroundColor: backgroundColor!)
    }
}
