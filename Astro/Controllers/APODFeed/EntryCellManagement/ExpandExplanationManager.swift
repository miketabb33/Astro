import UIKit

class ExpandExplanationManager {
    let addConstraints = EntryCellConstraints()
    
    //GET TOGGLE POSITION
    func getTogglePositionOfExplanation(cell: APODEntryCell, entry: APODEntryModel) {
        if entry.expandEnabled == true {
            showExpandedExplanation(cell: cell)
        } else {
            showCollapsedExplanation(cell: cell)
        }
    }
    
    //Getter Methods
    func showExpandedExplanation(cell: APODEntryCell) {
        cell.currentExpandExplanationButton.transform = CGAffineTransform(rotationAngle: .pi)
        cell.currentEntryExplanation.numberOfLines = 0
        cell.currentEntryExplanation.sizeToFit()
        self.addConstraints.addStackingConstraintTo(cell.currentEntryExplanation, stackUnder: cell.currentEntryImageView, edges: cell.contentView.layoutMarginsGuide, height: getExpandedEntryExplanationFrameHeight(rawFrameHeight: cell.currentEntryExplanation.frame.height))
    }
    
    func showCollapsedExplanation(cell: APODEntryCell) {
        cell.currentExpandExplanationButton.transform = .identity
        cell.currentEntryExplanation.numberOfLines = 7
        self.addConstraints.addStackingConstraintTo(cell.currentEntryExplanation, stackUnder: cell.currentEntryImageView, edges: cell.contentView.layoutMarginsGuide, height: cell.frameHeight["explanation"]!)
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
