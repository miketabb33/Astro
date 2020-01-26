import UIKit

class ImageProcessing {
    var image: UIImage
    
    let width: CGFloat
    let height: CGFloat
    let ratio: Double
    
    let screenWidth: CGFloat
    let aspectHeight: CGFloat
    
    let widePictureRatio = 1.25
    let tallPictureRatio = 0.75
    
    init(image: UIImage) {
        self.image = image
        
        width = image.size.width
        height = image.size.height
        ratio = Double(width/height)
        
        screenWidth = UIScreen.main.bounds.width
        aspectHeight = (screenWidth/width) * height
    }
    
    func getContentMode() -> UIView.ContentMode {
        var contentMode: UIView.ContentMode?
        
        if ratio <= tallPictureRatio {
            contentMode = .scaleAspectFit
        } else {
            contentMode = .scaleToFill
        }
        
        return contentMode!
    }

    
    
    func getImageDisplayHeight() -> CGFloat {
        if ratio >= widePictureRatio {
            return aspectHeight
        } else if ratio <= tallPictureRatio {
            return screenWidth
        } else {
            return screenWidth
        }
    }

}
