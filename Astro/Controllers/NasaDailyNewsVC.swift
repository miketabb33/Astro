import UIKit

class NasaDailyNewsVC: UIViewController {
    @IBOutlet weak var nasaHeader: UILabel!
    @IBOutlet weak var header: UIView!
    
    var isPageLayoutApplied = false
    
    
    var nasaImageContainer = UIImageView()
    let nasaTitle = UILabel()
    let nasaDescription = UITextView()
    
    let loadingAnimation = LoadingAnimation()
    let nasaDataHandler = NasaDataHandler()
    var nasaData = NasaDataModel() {
        didSet {
            nasaDataHandler.displayData(view, updateViewMethod: updateUIWithNasaData)
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
        if isPageLayoutApplied == false {
            nasaHeader.text = "Nasa News \(nasaData.date)"
            nasaTitle.text = nasaData.title
            nasaDescription.text = nasaData.description
            nasaImageContainer.image = nasaData.imageData
            insertElementsIntoUI()
            isPageLayoutApplied = true
        }
    }
    
    func insertElementsIntoUI() {
        view.addSubview(nasaImageContainer)
        nasaImageContainer = processImage(nasaImageContainer)
    }
    
    
    func processImage(_ imageView: UIImageView) -> UIImageView {
        if let image = imageView.image {
            
            imageView.translatesAutoresizingMaskIntoConstraints = false
            let safeArea = view.safeAreaLayoutGuide
            let screenWidth = UIScreen.main.bounds.width
            let width = image.size.width
            let height = image.size.height
            
            let ratio = width/height
            
            if ratio > 1.25 {
                NSLayoutConstraint.activate([
                    imageView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor),
                    imageView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor),
                    imageView.heightAnchor.constraint(equalToConstant: 100), //Find aspect ratio formula
                    imageView.topAnchor.constraint(equalToSystemSpacingBelow: header.bottomAnchor, multiplier: 0)
                    ])
                
                print(ratio)
            }
//            else if ratio < 0.75 {
//                imageView.frame = CGRect(x: 0, y: 0, width: screenWidth, height: screenWidth)
//            } else {
//
//                imageView.frame = CGRect(x: 0, y: 0, width: screenWidth, height: screenWidth)
//            }
        }
        return imageView
    }
}

