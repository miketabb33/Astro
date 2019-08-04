import Foundation
import Network

class InternetConnection {
    let monitor = NWPathMonitor()
    
    var isConnected = false
    
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
}
