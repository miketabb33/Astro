import UIKit

class NasaDailyNewsVC: UIViewController {
    @IBOutlet weak var nasaHeader: UILabel!
    @IBOutlet weak var header: UIView!
    
    var isPageLayoutApplied = false

    var nasaImageContainer = UIImageView()
    var nasaTitle = UILabel()
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
        view.addSubview(nasaTitle)
        
        processElements()
    }
    
    func processElements() {
        nasaImageContainer = processImage(nasaImageContainer)
        nasaTitle = processTitle(nasaTitle)
    }
    
    
    func processImage(_ imageView: UIImageView) -> UIImageView {
        if let image = imageView.image {
            
            imageView.translatesAutoresizingMaskIntoConstraints = false
            let screenWidth = UIScreen.main.bounds.width
            let width = image.size.width
            let height = image.size.height
            let safeArea = view.safeAreaLayoutGuide
            
            let aspectHeight = (screenWidth/width) * height
            
            let ratio = width/height
            
            if ratio >= 1.25 {
                addStackingConstraintTo(imageView, stackUnder: header, edges: safeArea, height: aspectHeight)
            }
            else if ratio <= 0.75 {
                imageView.contentMode = .scaleAspectFit
                addStackingConstraintTo(imageView, stackUnder: header, edges: safeArea, height: screenWidth)
            } else {
                imageView.contentMode = .scaleAspectFill
                addStackingConstraintTo(imageView, stackUnder: header, edges: safeArea, height: screenWidth)
            }
        }
        return imageView
    }
    
    func processTitle(_ labelView: UILabel) -> UILabel {
        if labelView.text != nil {
            labelView.translatesAutoresizingMaskIntoConstraints = false
            labelView.textColor = UIColor.white
            let margin = view.layoutMarginsGuide
            addStackingConstraintTo(labelView, stackUnder: nasaImageContainer, edges: margin, height: 50)
        }
        
        return labelView
    }
    
    func addStackingConstraintTo(_ element: UIView, stackUnder: UIView, edges: UILayoutGuide, height: CGFloat) {
        NSLayoutConstraint.activate([
            element.topAnchor.constraint(equalToSystemSpacingBelow: stackUnder.bottomAnchor, multiplier: 0),
            element.leadingAnchor.constraint(equalTo: edges.leadingAnchor),
            element.trailingAnchor.constraint(equalTo: edges.trailingAnchor),
            element.heightAnchor.constraint(equalToConstant: height)
        ])
    }
}

