import UIKit
import SVProgressHUD

class NasaDailyNewsVC: UIViewController {
    
    @IBOutlet weak var nasaImageContainer: UIImageView!
    
    @IBOutlet weak var nasaHeader: UILabel!
    
    @IBOutlet weak var nasaTitle: UILabel!
    
    @IBOutlet weak var nasaDescription: UILabel!
    
    var nasaDataModel = NasaDataModel()
    
    let screenWidth = UIScreen.main.bounds.width
    
    var nasaDataLoadedTrigger : UIImage? = nil {
        didSet{
            if view.isHidden == false {
                updateUIWithNasaData()
                SVProgressHUD.dismiss()
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        isNasaDataFinishedLoading()
        
        nasaImageContainer.frame = CGRect(x: 0, y: 0, width: screenWidth, height: screenWidth)
        
    }
    
    //MARK - update UI
    
    func isNasaDataFinishedLoading(){
        if nasaDataModel.imageData == nil {
            SVProgressHUD.show()
        } else {
            updateUIWithNasaData()
        }
    }
    
    func updateUIWithNasaData(){
        nasaHeader.text = "Nasa News \(nasaDataModel.date)"
        nasaTitle.text = nasaDataModel.title
        nasaDescription.text = nasaDataModel.description
        nasaImageContainer.image = nasaDataModel.imageData
    }
    
}

