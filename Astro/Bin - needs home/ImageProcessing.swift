import UIKit

class ImageProcessing {
    let constraints = EntryCellConstraints()
    
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
    
    func getImageRatioAndFit(currentCell: APODEntryCell, stackUnder topElement: UIView, edges edgeArea: UILayoutGuide) -> UIImageView {
        if ratio >= widePictureRatio {
            currentCell.APODImage = fitImage(imageHeight: aspectHeight, contentMode: .scaleToFill, currentCell: currentCell, stackUnder: topElement, edges: edgeArea)
        } else if ratio <= tallPictureRatio {
            currentCell.APODImage = fitImage(imageHeight: screenWidth, contentMode: .scaleAspectFit, currentCell: currentCell, stackUnder: topElement, edges: edgeArea)
        } else {
            currentCell.APODImage = fitImage(imageHeight: screenWidth, contentMode: .scaleToFill, currentCell: currentCell, stackUnder: topElement, edges: edgeArea)
        }
        
        return currentCell.APODImage
    }
    
    func fitImage(imageHeight: CGFloat, contentMode: UIView.ContentMode, currentCell: APODEntryCell, stackUnder topElement: UIView, edges edgeArea: UILayoutGuide) -> UIImageView {
        currentCell.APODImage.contentMode = contentMode
        currentCell.componentHeight["image"] = imageHeight
        constraints.addStackingConstraintTo(currentCell.APODImage, stackUnder: topElement, edges: edgeArea, height: imageHeight)
        
        return currentCell.APODImage
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
