import UIKit

class ExpandExplanationManager {
    let addConstraints = EntryCellConstraints()
    
    func toggleExplanationExpansion(entry: APODEntry, cell: APODTableViewCell) -> (Bool, Int) {
        var stateOfExpansion = false
        var newCellHeight = 0
        var newExplanationHeight: CGFloat = 0
        
        if entry.feedData.expandEnabled == false {
            stateOfExpansion = true
            resizeContentsAnimation(numberOfShowingLines: 0, cell: cell)
            newExplanationHeight = getExpandedEntryExplanationFrameHeight(rawFrameHeight: cell.explanationLabel.frame.height)
            
            updateConstraints(newHeight: newExplanationHeight, cell: cell)
            rotateArrowAnimation(cell: cell, arrowPosition: CGAffineTransform(rotationAngle: .pi))
            newCellHeight = 0//Int(Float(cell.componentHeight["title"]! + cell.componentHeight["image"]! + getExpandedEntryExplanationFrameHeight(rawFrameHeight: cell.explanation.frame.height) + cell.componentHeight["button"]!))
        } else {
            stateOfExpansion = false
            resizeContentsAnimation(numberOfShowingLines: 7, cell: cell)
            newExplanationHeight = 0//cell.componentHeight["explanation"]!
            
            updateConstraints(newHeight: newExplanationHeight, cell: cell)
            rotateArrowAnimation(cell: cell, arrowPosition: .identity)
            newCellHeight = 0//Int(Float(cell.componentHeight["title"]! + cell.componentHeight["image"]! + cell.componentHeight["explanation"]! + cell.componentHeight["button"]!))
        }
        return (stateOfExpansion, newCellHeight)
    }
    
    func updateConstraints(newHeight: CGFloat, cell: APODTableViewCell) {
        addConstraints.addStackingConstraintTo(cell.explanationLabel, stackUnder: cell.APODImageView, edges: cell.contentView.layoutMarginsGuide, height: newHeight)
    }
    
    func resizeContentsAnimation(numberOfShowingLines: Int, cell: APODTableViewCell) {
            UIView.transition(with: cell.explanationLabel, duration: 0.3, options: [.curveLinear], animations: {
                cell.explanationLabel.numberOfLines = numberOfShowingLines
                cell.explanationLabel.sizeToFit()
            })
    }
    
    func rotateArrowAnimation(cell: APODTableViewCell, arrowPosition: CGAffineTransform) {
        UIView.animate(withDuration: 0.3) {
            cell.expandButton.transform = arrowPosition
        }
    }

    func getExpandedEntryExplanationFrameHeight(rawFrameHeight: CGFloat) -> CGFloat {
        return rawFrameHeight + 10
    }
}
