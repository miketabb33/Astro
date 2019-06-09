import UIKit
import SVProgressHUD

class NasaDailyNewsVC: UIViewController {
    
    @IBOutlet weak var nasaImageContainer: UIImageView!
    @IBOutlet weak var nasaHeader: UILabel!
    @IBOutlet weak var nasaTitle: UILabel!
    @IBOutlet weak var nasaDescription: UILabel!
    
    var nasaData = updateNasaDataModel()
    
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
        
        let nasaDataCompletetionHandler: (Bool) -> Void = {
            if $0 {
                SVProgressHUD.dismiss()
                self.updateUIWithNasaData()
            }
        }
        
        nasaData.getNasaData(completion: nasaDataCompletetionHandler)
        
        nasaImageContainer.frame = CGRect(x: 0, y: 0, width: screenWidth, height: screenWidth)
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        isNasaDataFinishedLoading()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        //TO-DO:
        SVProgressHUD.dismiss()
    }
    
    //MARK - update UI
    
    func isNasaDataFinishedLoading() {
        if nasaData.nasaDataModel.imageData == nil {
            SVProgressHUD.show()
        } else {
            updateUIWithNasaData()
        }
    }
    
    func updateUIWithNasaData() {
        nasaHeader.text = "Nasa News \(nasaData.nasaDataModel.date)"
        nasaTitle.text = nasaData.nasaDataModel.title
        nasaDescription.text = nasaData.nasaDataModel.description
        nasaImageContainer.image = nasaData.nasaDataModel.imageData
    }
    
}

