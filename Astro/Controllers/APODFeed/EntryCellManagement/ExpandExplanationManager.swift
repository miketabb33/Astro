import UIKit

class ExpandExplanationManager {
    let addConstraints = EntryCellConstraints()
    
    //GET TOGGLE POSITION
    func getTogglePositionOfExplanation(cell: APODEntryCell, entry: APODEntryModel) {
        var explanationHeight: CGFloat = 0
        if entry.expandEnabled == true {
            explanationHeight = cell.currentEntryExplanation.frame.height
            
            showExplanation(cell: cell, numberOfLines: 0, height: explanationHeight, arrowPosition: CGAffineTransform(rotationAngle: .pi))
        } else {
            explanationHeight = cell.frameHeight["explanation"]!
            
            showExplanation(cell: cell, numberOfLines: 7, height: explanationHeight, arrowPosition: .identity)
        }
    }
    
    func showExplanation(cell: APODEntryCell, numberOfLines: Int, height: CGFloat, arrowPosition: CGAffineTransform) {
        cell.currentExpandExplanationButton.transform = arrowPosition
        cell.currentEntryExplanation.numberOfLines = numberOfLines
        addConstraints.addStackingConstraintTo(cell.currentEntryExplanation, stackUnder: cell.currentEntryImageView, edges: cell.contentView.layoutMarginsGuide, height: height)
    }
    
    //MARK: SET TOGGLE POSITION
    
    func toggleExplanationExpansion(entry: APODEntryModel, cell: APODEntryCell) -> (Bool, Int) {
        var stateOfExpansion = false
        var newCellHeight = 0
        var newExplanationHeight: CGFloat = 0
        
        if entry.expandEnabled == false {
            stateOfExpansion = true
            resizeContentsAnimation(numberOfShowingLines: 0, cell: cell)
            newExplanationHeight = getExpandedEntryExplanationFrameHeight(rawFrameHeight: cell.currentEntryExplanation.frame.height)
            
            updateConstraints(newHeight: newExplanationHeight, cell: cell)
            rotateArrowAnimation(cell: cell, arrowPosition: CGAffineTransform(rotationAngle: .pi))
            newCellHeight = Int(Float(cell.frameHeight["title"]! + cell.frameHeight["image"]! + getExpandedEntryExplanationFrameHeight(rawFrameHeight: cell.currentEntryExplanation.frame.height) + cell.frameHeight["button"]!))
        } else {
            stateOfExpansion = false
            resizeContentsAnimation(numberOfShowingLines: 7, cell: cell)
            newExplanationHeight = cell.frameHeight["explanation"]!
            
            updateConstraints(newHeight: newExplanationHeight, cell: cell)
            rotateArrowAnimation(cell: cell, arrowPosition: .identity)
            newCellHeight = Int(Float(cell.frameHeight["title"]! + cell.frameHeight["image"]! + cell.frameHeight["explanation"]! + cell.frameHeight["button"]!))
        }
        return (stateOfExpansion, newCellHeight)
    }
    
    func updateConstraints(newHeight: CGFloat, cell: APODEntryCell) {
        addConstraints.addStackingConstraintTo(cell.currentEntryExplanation, stackUnder: cell.currentEntryImageView, edges: cell.contentView.layoutMarginsGuide, height: newHeight)
    }
    
    func resizeContentsAnimation(numberOfShowingLines: Int, cell: APODEntryCell) {
            UIView.transition(with: cell.currentEntryExplanation, duration: 0.3, options: [.curveLinear], animations: {
                cell.currentEntryExplanation.numberOfLines = numberOfShowingLines
                cell.currentEntryExplanation.sizeToFit()
            })
    }
    
    func rotateArrowAnimation(cell: APODEntryCell, arrowPosition: CGAffineTransform) {
        UIView.animate(withDuration: 0.3) {
            cell.currentExpandExplanationButton.transform = arrowPosition
        }
    }

    func getExpandedEntryExplanationFrameHeight(rawFrameHeight: CGFloat) -> CGFloat {
        return rawFrameHeight + 10
    }
}
