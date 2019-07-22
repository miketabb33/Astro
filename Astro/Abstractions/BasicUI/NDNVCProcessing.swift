import UIKit

class NDNVCProcessing {
    let constraints = UIConstraints()
    
    func processImage(currentCell: NasaNewsEntryCell, stackUnder topElement: UIView, edges edgeArea: UILayoutGuide) -> UIImageView {

        let width = currentCell.currentEntryImageView.image!.size.width
        let height = currentCell.currentEntryImageView.image!.size.height
        let ratio = width/height
        
        let screenWidth = UIScreen.main.bounds.width
        let aspectHeight = (screenWidth/width) * height
        
        if ratio >= 1.25 {
            currentCell.currentEntryImageView.contentMode = .scaleToFill
            currentCell.imageFrameHeight = aspectHeight
            constraints.addStackingConstraintTo(currentCell.currentEntryImageView, stackUnder: topElement, edges: edgeArea, height: aspectHeight)
        } else if ratio <= 0.75 {
            currentCell.currentEntryImageView.contentMode = .scaleAspectFit
            currentCell.imageFrameHeight = screenWidth
            constraints.addStackingConstraintTo(currentCell.currentEntryImageView, stackUnder: topElement, edges: edgeArea, height: screenWidth)
        } else {
            currentCell.currentEntryImageView.contentMode = .scaleToFill
            currentCell.imageFrameHeight = screenWidth
            constraints.addStackingConstraintTo(currentCell.currentEntryImageView, stackUnder: topElement, edges: edgeArea, height: screenWidth)
        }
        
        return currentCell.currentEntryImageView
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
