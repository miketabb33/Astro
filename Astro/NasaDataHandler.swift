import UIKit

class NasaDataHandler {
    let loadingAnimation = LoadingAnimation()
    let fetchNasaDailyNewsData = FetchNasaDailyNewsData()
    let apiRequest = APIRequest()
    
    func loadDataWhenViewIsShowing(_ view: UIView, updateViewMethod: () -> Void) {
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
            nasaDailyNewsView.nasaData = self.fetchNasaDailyNewsData.nasaData
        }
        
        apiRequest.getData(api_url: fetchNasaDailyNewsData.api_url, api_key: fetchNasaDailyNewsData.api_key, action: fetchNasaDailyNewsData.updateModelWithNasaData, completion: nasaDataCompletetionHandler)
    }
    
}
