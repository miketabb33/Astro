import UIKit

class NDNVCProcessing {
    let constraints = UIConstraints()
    
    func processImage(_ imageView: UIImageView, stackUnder topElement: UIView, edges edgeArea: UILayoutGuide) -> UIImageView {
        if let image = imageView.image {

            let width = image.size.width
            let height = image.size.height
            let ratio = width/height
            
            let screenWidth = UIScreen.main.bounds.width
            let aspectHeight = (screenWidth/width) * height
            
            configureImageView(imageView, ratio: ratio, topElement: topElement, edgeArea: edgeArea, aspectHeight: aspectHeight, screenWidth: screenWidth)
            
        }
        return imageView
    }
    
    func configureImageView(_ imageView: UIImageView, ratio: CGFloat, topElement: UIView, edgeArea: UILayoutGuide, aspectHeight: CGFloat, screenWidth: CGFloat) {
            if ratio >= 1.25 {
                imageView.contentMode = .scaleToFill
                constraints.addStackingConstraintTo(imageView, stackUnder: topElement, edges: edgeArea, height: aspectHeight)
            } else if ratio <= 0.75 {
                imageView.contentMode = .scaleAspectFit
                constraints.addStackingConstraintTo(imageView, stackUnder: topElement, edges: edgeArea, height: screenWidth)
            } else {
                imageView.contentMode = .scaleToFill
                constraints.addStackingConstraintTo(imageView, stackUnder: topElement, edges: edgeArea, height: screenWidth)
            }
    }
    
    func processTitle(_ labelView: UILabel, topAnchor: NSLayoutYAxisAnchor, edges edgeArea: UILayoutGuide) -> UILabel {
        if labelView.text != nil {
            
            //constraints.addConstraintForTopMostElementTo(labelView, topAnchor: topAnchor, edges: edgeArea, height: 50)
        }
        
        return labelView
    }
    
    func processExplanation(_ labelView: UILabel, stackUnder topElement: UIView, edges edgeArea: UILayoutGuide) -> UILabel {
        if labelView.text != nil {
            labelView.font = UIFont (name: "Palatino", size: 14)
            labelView.numberOfLines = 0
            labelView.textColor = UIColor.black
            labelView.backgroundColor = UIColor.clear
            labelView.translatesAutoresizingMaskIntoConstraints = false
            constraints.addStackingConstraintTo(labelView, stackUnder: topElement, edges: edgeArea, height: 120)
        }
        
        return labelView
    }

}
