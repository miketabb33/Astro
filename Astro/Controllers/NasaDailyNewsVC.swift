import UIKit
import SVProgressHUD

class NasaDailyNewsVC: UIViewController {
    
    @IBOutlet weak var nasaImageContainer: UIImageView!
    @IBOutlet weak var nasaHeader: UILabel!
    @IBOutlet weak var nasaTitle: UILabel!
    @IBOutlet weak var nasaDescription: UILabel!

    var nasaData = NasaDataModel() {
        didSet {
            if view.isHidden == false {
                updateUIWithNasaData()
                SVProgressHUD.dismiss()
            }
        }
    }
    
    let screenWidth = UIScreen.main.bounds.width
    
    //MARK: - View Status

    override func viewDidLoad() {
        super.viewDidLoad()
        
        nasaImageContainer.frame = CGRect(x: 0, y: 0, width: screenWidth, height: screenWidth)
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        isNasaDataFinishedLoading()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        SVProgressHUD.dismiss()
    }
    
    //MARK - update UI
    
    func isNasaDataFinishedLoading() {
        if nasaData.imageData == nil {
            SVProgressHUD.show()
        } else {
            updateUIWithNasaData()
        }
    }
    
    func updateUIWithNasaData() {
        nasaHeader.text = "Nasa News \(nasaData.date)"
        nasaTitle.text = nasaData.title
        nasaDescription.text = nasaData.description
        nasaImageContainer.image = nasaData.imageData
    }
    
}

