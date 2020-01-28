import UIKit

class Notifier {
    func await(onComplete: @escaping () -> Void, updateConditional: @escaping () -> Bool, onLoading: (() -> Void)? = nil, onTimeOut: (() -> Void)? = nil, timeOutTime: Int = 60) {
        var isLoading = false
        var conditional = false
        
        let timeOutLimit = timeOutTime * 4
        var timeOutCounter = 0
        
        Timer.scheduledTimer(withTimeInterval: 0.25, repeats: true) { (timer) in
            conditional = updateConditional()
            
            if conditional {
                onComplete()
                isLoading = false
                timer.invalidate()
            } else {
                if isLoading == false {
                    onLoading?()
                    isLoading = true
                }
                
                timeOutCounter += 1
                if timeOutCounter >= timeOutLimit {
                    onTimeOut?()
                    timer.invalidate()
                }
            }
        }
    }
}
