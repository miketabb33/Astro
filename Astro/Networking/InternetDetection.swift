import UIKit
import Network

class InternetDetection {
    let monitor = NWPathMonitor()
    
    var alertVC: DropDownAlertVC?
    
    var parentVC: UIViewController
    init(parentVC: UIViewController) {
        self.parentVC = parentVC
    }
    
    var isConnected: Bool? = nil {
        didSet {
            toggleAlert(newValue: self.isConnected, oldValue: oldValue)
        }
    }
    
    func startMonitoringInternetConnection() {
        monitor.pathUpdateHandler = { path in
            self.connectionHandler(path: path)
        }
        
        let queue = DispatchQueue(label: "Monitor")
        monitor.start(queue: queue)
    }
    
    func connectionHandler(path: NWPath) {
        if path.status == .satisfied {
            isConnected = true
        } else {
            isConnected = false
        }
    }
    
    func toggleAlert(newValue: Bool?, oldValue: Bool?) {
        if newValue == true && newValue != oldValue {
            DispatchQueue.main.async {
                self.alertVC = DropDownAlertManager().removeAlertFromScreen(alertVC: self.alertVC)
            }
        } else if newValue == false && newValue != oldValue {
            DispatchQueue.main.async {
                self.alertVC = DropDownAlertManager().createAndAddAlertToScreen(parentVC: self.parentVC, message: "No Internet", backgroundColor: UIColor.danger(alpha: 0.93))
            }
        }
    }
}
