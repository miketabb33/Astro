import UIKit

class ExpandExplanationManager {
    let addConstraints = EntryCellConstraints()
    let realmMethods = RealmPath()
    
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
    func toggleController(entry: APODEntryModel, cell: APODEntryCell, tableView: UITableView) -> (Bool, Int) {
        if entry.expandEnabled == false {
            return expandExplanationLabel(entry: entry, cell: cell, tableView: tableView)
        } else {
            return collapseExplanationLabel(entry: entry, cell: cell, tableView: tableView)
        }
    }
    
    //Expand Explanation Label
    func expandExplanationLabel(entry: APODEntryModel, cell: APODEntryCell, tableView: UITableView) -> (Bool, Int) {
        expandExplanationLabalAnimation(cell: cell)
        addConstraints.addStackingConstraintTo(cell.currentEntryExplanation, stackUnder: cell.currentEntryImageView, edges: cell.contentView.layoutMarginsGuide, height: self.getExpandedEntryExplanationFrameHeight(rawFrameHeight: cell.currentEntryExplanation.frame.height))
        
        let isExpanded = true
        let newExplanationHeight = Int(Float(cell.frameHeight["title"]! + cell.frameHeight["image"]! + getExpandedEntryExplanationFrameHeight(rawFrameHeight: cell.currentEntryExplanation.frame.height) + cell.frameHeight["button"]!))
        
        animateExpandLabelConstraints(cell: cell, arrowPosition: CGAffineTransform(rotationAngle: .pi))
        cellHeightAnimation(tableView: tableView)
        
        return (isExpanded, newExplanationHeight)
    }
    
    func expandExplanationLabalAnimation(cell: APODEntryCell) {
        UIView.transition(with: cell.currentEntryExplanation, duration: 0.3, options: [.curveLinear], animations: { () -> Void in
            cell.currentEntryExplanation.numberOfLines = 0
            cell.currentEntryExplanation.sizeToFit()
        }, completion: nil)
    }
    
    //Collapse Explanation Label
    func collapseExplanationLabel(entry: APODEntryModel, cell: APODEntryCell, tableView: UITableView) -> (Bool, Int) {
        collapseExplanationLabelAnimation(cell: cell)
        addConstraints.addStackingConstraintTo(cell.currentEntryExplanation, stackUnder: cell.currentEntryImageView, edges: cell.contentView.layoutMarginsGuide, height: cell.frameHeight["explanation"]!)
        
        let isExpanded = true
        let newExplanationHeight = Int(Float(cell.frameHeight["title"]! + cell.frameHeight["image"]! + cell.frameHeight["explanation"]! + cell.frameHeight["button"]!))

        animateExpandLabelConstraints(cell: cell, arrowPosition: .identity)
        cellHeightAnimation(tableView: tableView)
        
        return (isExpanded, newExplanationHeight)
    }
    
    func collapseExplanationLabelAnimation(cell: APODEntryCell) {
        UIView.transition(with: cell.currentEntryExplanation, duration: 0.3, options: [.curveLinear], animations: { () -> Void in
            cell.currentEntryExplanation.numberOfLines = 7
        }, completion: nil)
    }

    //Setter Methods
    func animateExpandLabelConstraints(cell: APODEntryCell, arrowPosition: CGAffineTransform) {
        UIView.animate(withDuration: 0.3) {
            cell.currentExpandExplanationButton.transform = arrowPosition
            cell.layoutIfNeeded()
        }
    }
    
    func cellHeightAnimation(tableView: UITableView) {
        tableView.beginUpdates()
        tableView.endUpdates()
    }
    
    //MARK: - Getter/Setter Methods
    func getExpandedEntryExplanationFrameHeight(rawFrameHeight: CGFloat) -> CGFloat {
        return rawFrameHeight + 10
    }
}
