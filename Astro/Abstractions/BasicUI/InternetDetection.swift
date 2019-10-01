import UIKit
import Network

class InternetDetection {
    let monitor = NWPathMonitor()
    let bsColors = BootStrapColors()
    
    var isConnected = false {
        willSet {
            if newValue == true {
                removeNoInternetMessage()
            } else {
                addNoInternetMessage()
            }
        }
    }
    
    var messageLabel = UILabel()
    var parentView = UIView()
    
    func assignComponents(messageLabel: UILabel, parentView: UIView) {
        self.messageLabel = messageLabel
        self.parentView = parentView
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
    
    func removeNoInternetMessage() {
        DispatchQueue.main.async {
            self.messageLabel.removeConstraints(self.messageLabel.constraints)
            self.messageLabel.heightAnchor.constraint(equalToConstant: 0).isActive = true
            UIView.animate(withDuration: 0.3, animations: {
                self.parentView.layoutIfNeeded()
            })
        }
    }
    
    func addNoInternetMessage() {
        DispatchQueue.main.async {
            self.messageLabel.backgroundColor = self.bsColors.danger
            self.messageLabel.text = "No Internet"
            self.messageLabel.removeConstraints(self.messageLabel.constraints)
            self.messageLabel.heightAnchor.constraint(equalToConstant: 44).isActive = true
            UIView.animate(withDuration: 0.3, animations: {
                self.parentView.layoutIfNeeded()
            })
        }
    }
}
