import UIKit

class ExpandExplanationManager {
    let addConstraints = EntryCellConstraints()
    
    func toggleExplanationExpansion(entry: APODEntryModel, cell: APODEntryCell) -> (Bool, Int) {
        var stateOfExpansion = false
        var newCellHeight = 0
        var newExplanationHeight: CGFloat = 0
        
        if entry.expandEnabled == false {
            stateOfExpansion = true
            resizeContentsAnimation(numberOfShowingLines: 0, cell: cell)
            newExplanationHeight = getExpandedEntryExplanationFrameHeight(rawFrameHeight: cell.explanation.frame.height)
            
            updateConstraints(newHeight: newExplanationHeight, cell: cell)
            rotateArrowAnimation(cell: cell, arrowPosition: CGAffineTransform(rotationAngle: .pi))
            newCellHeight = Int(Float(cell.componentHeight["title"]! + cell.componentHeight["image"]! + getExpandedEntryExplanationFrameHeight(rawFrameHeight: cell.explanation.frame.height) + cell.componentHeight["button"]!))
        } else {
            stateOfExpansion = false
            resizeContentsAnimation(numberOfShowingLines: 7, cell: cell)
            newExplanationHeight = cell.componentHeight["explanation"]!
            
            updateConstraints(newHeight: newExplanationHeight, cell: cell)
            rotateArrowAnimation(cell: cell, arrowPosition: .identity)
            newCellHeight = Int(Float(cell.componentHeight["title"]! + cell.componentHeight["image"]! + cell.componentHeight["explanation"]! + cell.componentHeight["button"]!))
        }
        return (stateOfExpansion, newCellHeight)
    }
    
    func updateConstraints(newHeight: CGFloat, cell: APODEntryCell) {
        addConstraints.addStackingConstraintTo(cell.explanation, stackUnder: cell.APODImage, edges: cell.contentView.layoutMarginsGuide, height: newHeight)
    }
    
    func resizeContentsAnimation(numberOfShowingLines: Int, cell: APODEntryCell) {
            UIView.transition(with: cell.explanation, duration: 0.3, options: [.curveLinear], animations: {
                cell.explanation.numberOfLines = numberOfShowingLines
                cell.explanation.sizeToFit()
            })
    }
    
    func rotateArrowAnimation(cell: APODEntryCell, arrowPosition: CGAffineTransform) {
        UIView.animate(withDuration: 0.3) {
            cell.expandButton.transform = arrowPosition
        }
    }

    func getExpandedEntryExplanationFrameHeight(rawFrameHeight: CGFloat) -> CGFloat {
        return rawFrameHeight + 10
    }
}
