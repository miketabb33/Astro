import UIKit
import SVProgressHUD

class NasaDailyNewsVC: UIViewController {
    
    @IBOutlet weak var nasaImageContainer: UIImageView!
    @IBOutlet weak var nasaHeader: UILabel!
    @IBOutlet weak var nasaTitle: UILabel!
    @IBOutlet weak var nasaDescription: UILabel!
    
    let screenWidth = UIScreen.main.bounds.width
    let nasaDataHandler = NasaDataHandler()
    var nasaData = NasaDataModel() {
        didSet {
            nasaDataHandler.loadDataWhenViewIsShowing(view, updateViewMethod: updateUIWithNasaData)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        nasaImageContainer.frame = CGRect(x: 0, y: 0, width: screenWidth, height: screenWidth)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        nasaDataHandler.isDataFinishedLoading(indicator: nasaData.imageData, updateViewMethod: updateUIWithNasaData)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        SVProgressHUD.dismiss()
    }
    
    //MARK - update UI
    
    func updateUIWithNasaData() {
        nasaHeader.text = "Nasa News \(nasaData.date)"
        nasaTitle.text = nasaData.title
        nasaDescription.text = nasaData.description
        nasaImageContainer.image = nasaData.imageData
    }
    
}

