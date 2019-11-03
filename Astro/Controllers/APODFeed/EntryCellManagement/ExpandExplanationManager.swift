import UIKit
import RealmSwift

class ExpandExplanationManager {
    let addConstraints = EntryCellConstraints()
    let realmMethods = RealmMethods()
    
    //GET TOGGLE POSITION
    func getTogglePositionOfExplanation(cell: APODEntryCell, allAPODEntries: Results<APODEntry>, indexPath: IndexPath) {
        if allAPODEntries[indexPath.row].expandEnabled == true {
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
    func toggleController(allAPODEntries: Results<APODEntry>, indexPath: IndexPath, cell: APODEntryCell, tableView: UITableView) {
        if allAPODEntries[indexPath.row].expandEnabled == false {
            expandExplanationLabel(allAPODEntries: allAPODEntries, indexPath: indexPath, cell: cell, tableView: tableView)
        } else {
            collapseExplanationLabel(allAPODEntries: allAPODEntries, indexPath: indexPath, cell: cell, tableView: tableView)
        }
    }
    
    //Expand Explanation Label
    func expandExplanationLabel(allAPODEntries: Results<APODEntry>, indexPath: IndexPath, cell: APODEntryCell, tableView: UITableView) {
        try! realmMethods.realm.write {
            allAPODEntries[indexPath.row].expandEnabled = true
        }
        expandExplanationLabalAnimation(cell: cell)
        addConstraints.addStackingConstraintTo(cell.currentEntryExplanation, stackUnder: cell.currentEntryImageView, edges: cell.contentView.layoutMarginsGuide, height: self.getExpandedEntryExplanationFrameHeight(rawFrameHeight: cell.currentEntryExplanation.frame.height))
        
        try! realmMethods.realm.write {
            allAPODEntries[indexPath.row].cellHeight = Int(Float(cell.frameHeight["title"]! + cell.frameHeight["image"]! + getExpandedEntryExplanationFrameHeight(rawFrameHeight: cell.currentEntryExplanation.frame.height) + cell.frameHeight["button"]!))
        }
        animateExpandLabelConstraints(cell: cell, arrowPosition: CGAffineTransform(rotationAngle: .pi))
        cellHeightAnimation(tableView: tableView)
    }
    
    func expandExplanationLabalAnimation(cell: APODEntryCell) {
        UIView.transition(with: cell.currentEntryExplanation, duration: 0.3, options: [.curveLinear], animations: { () -> Void in
            cell.currentEntryExplanation.numberOfLines = 0
            cell.currentEntryExplanation.sizeToFit()
        }, completion: nil)
    }
    
    //Collapse Explanation Label
    func collapseExplanationLabel(allAPODEntries: Results<APODEntry>, indexPath: IndexPath, cell: APODEntryCell, tableView: UITableView) {
        
        try! realmMethods.realm.write {
            allAPODEntries[indexPath.row].expandEnabled = false
        }
        
        collapseExplanationLabelAnimation(cell: cell)
        addConstraints.addStackingConstraintTo(cell.currentEntryExplanation, stackUnder: cell.currentEntryImageView, edges: cell.contentView.layoutMarginsGuide, height: cell.frameHeight["explanation"]!)
        try! realmMethods.realm.write {
            allAPODEntries[indexPath.row].cellHeight = Int(Float(cell.frameHeight["title"]! + cell.frameHeight["image"]! + cell.frameHeight["explanation"]! + cell.frameHeight["button"]!))
        }
        

        animateExpandLabelConstraints(cell: cell, arrowPosition: .identity)
        cellHeightAnimation(tableView: tableView)
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
