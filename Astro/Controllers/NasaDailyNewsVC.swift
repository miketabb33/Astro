import UIKit
import SVProgressHUD

class NasaDailyNewsVC: UIViewController {
    
    @IBOutlet weak var nasaImageContainer: UIImageView!
    
    @IBOutlet weak var nasaHeader: UILabel!
    
    @IBOutlet weak var nasaTitle: UILabel!
    
    @IBOutlet weak var nasaDescription: UILabel!
    
    var nasaDataModel = NasaDataModel()
    
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

