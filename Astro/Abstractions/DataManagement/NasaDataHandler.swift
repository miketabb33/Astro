import UIKit

class NasaDataHandler {
    let loadingAnimation = LoadingAnimation()
    let updateNasaModel = UpdateNasaModel()
    let apiRequest = NDNAPI()
    
    let api_key = "O5XtjFT6wV1o5zLwNDhhwf8giPbWhlasYL24H69p"
    let api_url = "https://api.nasa.gov/planetary/apod"
    
    func displayData(_ view: UIView, updateViewMethod: () -> Void) {
        if view.isHidden == false {
            updateViewMethod()
            loadingAnimation.hide()
        }
    }
    
    func isDataFinishedLoading(indicator: UIImage?, updateViewMethod: () -> Void) {
        if indicator == nil {
            loadingAnimation.show()
        } else {
            updateViewMethod()
        }
    }
    
    func sendNasaDailyNewsDataToView(_ target: UIViewController?) {
        let nasaDailyNewsView = target as! NasaDailyNewsVC
        
        let nasaDataCompletetionHandler: () -> Void = {
            nasaDailyNewsView.nasaData = self.updateNasaModel.nasaData
        }

    }
    
}
