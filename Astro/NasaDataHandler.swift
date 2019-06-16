import UIKit

class NasaDataHandler {
    let loadingAnimation = LoadingAnimation()
    let fetchNasaDailyNewsData = FetchNasaDailyNewsData()
    
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
        
        fetchNasaDailyNewsData.getNasaData(completion: nasaDataCompletetionHandler)
    }
    
}
