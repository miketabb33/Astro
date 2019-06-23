import UIKit

class NasaDailyNewsVC: UIViewController {
    @IBOutlet weak var nasaImageContainer: UIImageView!
    @IBOutlet weak var nasaHeader: UILabel!
    @IBOutlet weak var nasaTitle: UILabel!
    @IBOutlet weak var nasaDescription: UILabel!
    
    let screenWidth = UIScreen.main.bounds.width
    
    let loadingAnimation = LoadingAnimation()
    let nasaDataHandler = NasaDataHandler()
    var nasaData = NasaDataModel() {
        didSet {
            nasaDataHandler.displayData(view, updateViewMethod: updateUIWithNasaData)
            nasaImageContainer = processImage(nasaImageContainer)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        nasaDataHandler.isDataFinishedLoading(indicator: nasaData.imageData, updateViewMethod: updateUIWithNasaData)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        loadingAnimation.hide()
    }
    
    //MARK - update UI
    
    func updateUIWithNasaData() {
        nasaHeader.text = "Nasa News \(nasaData.date)"
        nasaTitle.text = nasaData.title
        nasaDescription.text = nasaData.description
        nasaImageContainer.image = nasaData.imageData
    }
    
    func processImage(_ imageView: UIImageView) -> UIImageView {
        if let image = imageView.image {
            let width = image.size.width
            let height = image.size.height
            
            let ratio = width/height
            
            if ratio > 1.25 {
                imageView.contentMode = .scaleAspectFit
            } else if ratio < 0.75 {
                imageView.contentMode = .scaleAspectFit
            }
            
            print(ratio)
        }
        return imageView
    }
}

