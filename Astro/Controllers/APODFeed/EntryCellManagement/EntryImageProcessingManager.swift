import UIKit

class EntryImageProcessingManager {
    let constraints = EntryCellConstraints()
    
    func processImage(currentCell: APODEntryCell, stackUnder topElement: UIView, edges edgeArea: UILayoutGuide) -> UIImageView {

        let width = currentCell.currentEntryImageView.image!.size.width
        let height = currentCell.currentEntryImageView.image!.size.height
        let ratio = width/height
        
        let screenWidth = UIScreen.main.bounds.width
        let aspectHeight = (screenWidth/width) * height
        
        if ratio >= 1.25 {
            currentCell.currentEntryImageView.contentMode = .scaleToFill
            currentCell.frameHeight["image"] = aspectHeight
            constraints.addStackingConstraintTo(currentCell.currentEntryImageView, stackUnder: topElement, edges: edgeArea, height: aspectHeight)
        } else if ratio <= 0.75 {
            currentCell.currentEntryImageView.contentMode = .scaleAspectFit
            currentCell.frameHeight["image"] = screenWidth
            constraints.addStackingConstraintTo(currentCell.currentEntryImageView, stackUnder: topElement, edges: edgeArea, height: screenWidth)
        } else {
            currentCell.currentEntryImageView.contentMode = .scaleToFill
            currentCell.frameHeight["image"] = screenWidth
            constraints.addStackingConstraintTo(currentCell.currentEntryImageView, stackUnder: topElement, edges: edgeArea, height: screenWidth)
        }
        
        return currentCell.currentEntryImageView
    }

}
