import UIKit

class NasaDailyNewsVC: UIViewController {
    @IBOutlet weak var nasaHeader: UILabel!
    @IBOutlet weak var header: UIView!

    let loadingAnimation = LoadingAnimation()
    let nasaDataHandler = NasaDataHandler()
    let processUIElements = NDNVCProcessing()

    var isPageLayoutApplied = false
    var nasaImageContainer = UIImageView()
    var nasaTitle = UILabel()
    var nasaDescription = UILabel()
    var nasaData = NasaDataModel() {
        didSet {
            nasaDataHandler.displayData(view, updateViewMethod: updateNasaData)
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func viewDidAppear(_ animated: Bool) {
        nasaDataHandler.isDataFinishedLoading(indicator: nasaData.imageData, updateViewMethod: updateNasaData)
    }

    override func viewDidDisappear(_ animated: Bool) {
        loadingAnimation.hide()
    }

    //MARK - update UI

    func updateNasaData() {
        if isPageLayoutApplied == false {
            isPageLayoutApplied = true
            nasaHeader.text = "Nasa News \(nasaData.date)"
            nasaTitle.text = nasaData.title
            nasaDescription.text = nasaData.description
            nasaImageContainer.image = nasaData.imageData
            insertElementsIntoUI()
        }
    }

    func insertElementsIntoUI() {
        view.addSubview(nasaImageContainer)
        view.addSubview(nasaTitle)
        view.addSubview(nasaDescription)
        processElements()
    }

    func processElements() {
        let safeArea = view.safeAreaLayoutGuide
        let margin = view.layoutMarginsGuide
        //nasaImageContainer = processUIElements.processImage(nasaImageContainer, stackUnder: header, edges: safeArea)
        //nasaTitle = processUIElements.processTitle(nasaTitle, stackUnder: nasaImageContainer, edges: margin)
        //nasaDescription = processUIElements.processDescription(nasaDescription, stackUnder: nasaTitle, edges: margin)
    }
}

