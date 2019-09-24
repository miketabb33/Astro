import UIKit
import RealmSwift

class ExpandExplanationManager {
    let addConstraints = UIConstraints()
    let persistentData = PersistentData()
    
    //GET TOGGLE POSITION
    func getTogglePositionOfExplanation(cell: NasaNewsEntryCell, allNasaEntries: Results<APODEntry>, indexPath: IndexPath) {
        if allNasaEntries[indexPath.row].expandEnabled == true {
            showExpandedExplanation(cell: cell)
        } else {
            showCollapsedExplanation(cell: cell)
        }
    }
    
    //Getter Methods
    func showExpandedExplanation(cell: NasaNewsEntryCell) {
        cell.currentExpandExplanationButton.transform = CGAffineTransform(rotationAngle: .pi)
        cell.currentEntryExplanation.numberOfLines = 0
        cell.currentEntryExplanation.sizeToFit()
        self.addConstraints.addStackingConstraintTo(cell.currentEntryExplanation, stackUnder: cell.currentEntryImageView, edges: cell.contentView.layoutMarginsGuide, height: getExpandedEntryExplanationFrameHeight(rawFrameHeight: cell.currentEntryExplanation.frame.height))
    }
    
    func showCollapsedExplanation(cell: NasaNewsEntryCell) {
        cell.currentExpandExplanationButton.transform = .identity
        cell.currentEntryExplanation.numberOfLines = 7
        self.addConstraints.addStackingConstraintTo(cell.currentEntryExplanation, stackUnder: cell.currentEntryImageView, edges: cell.contentView.layoutMarginsGuide, height: cell.frameHeight["explanation"]!)
    }
    
    //MARK: SET TOGGLE POSITION
    func toggleController(allNasaEntries: Results<APODEntry>, indexPath: IndexPath, cell: NasaNewsEntryCell, tableView: UITableView) {
        if allNasaEntries[indexPath.row].expandEnabled == false {
            expandExplanationLabel(allNasaEntries: allNasaEntries, indexPath: indexPath, cell: cell, tableView: tableView)
        } else {
            collapseExplanationLabel(allNasaEntries: allNasaEntries, indexPath: indexPath, cell: cell, tableView: tableView)
        }
    }
    
    //Expand Explanation Label
    func expandExplanationLabel(allNasaEntries: Results<APODEntry>, indexPath: IndexPath, cell: NasaNewsEntryCell, tableView: UITableView) {
        try! persistentData.realm.write {
            allNasaEntries[indexPath.row].expandEnabled = true
        }
        expandExplanationLabalAnimation(cell: cell)
        addConstraints.addStackingConstraintTo(cell.currentEntryExplanation, stackUnder: cell.currentEntryImageView, edges: cell.contentView.layoutMarginsGuide, height: self.getExpandedEntryExplanationFrameHeight(rawFrameHeight: cell.currentEntryExplanation.frame.height))
        
        try! persistentData.realm.write {
            allNasaEntries[indexPath.row].cellHeight = Int(Float(cell.frameHeight["title"]! + cell.frameHeight["image"]! + getExpandedEntryExplanationFrameHeight(rawFrameHeight: cell.currentEntryExplanation.frame.height) + cell.frameHeight["button"]!))
        }
        animateExpandLabelConstraints(cell: cell, arrowPosition: CGAffineTransform(rotationAngle: .pi))
        cellHeightAnimation(tableView: tableView)
    }
    
    func expandExplanationLabalAnimation(cell: NasaNewsEntryCell) {
        UIView.transition(with: cell.currentEntryExplanation, duration: 0.3, options: [.curveLinear], animations: { () -> Void in
            cell.currentEntryExplanation.numberOfLines = 0
            cell.currentEntryExplanation.sizeToFit()
        }, completion: nil)
    }
    
    //Collapse Explanation Label
    func collapseExplanationLabel(allNasaEntries: Results<APODEntry>, indexPath: IndexPath, cell: NasaNewsEntryCell, tableView: UITableView) {
        
        try! persistentData.realm.write {
            allNasaEntries[indexPath.row].expandEnabled = false
        }
        
        collapseExplanationLabelAnimation(cell: cell)
        addConstraints.addStackingConstraintTo(cell.currentEntryExplanation, stackUnder: cell.currentEntryImageView, edges: cell.contentView.layoutMarginsGuide, height: cell.frameHeight["explanation"]!)
        try! persistentData.realm.write {
            allNasaEntries[indexPath.row].cellHeight = Int(Float(cell.frameHeight["title"]! + cell.frameHeight["image"]! + cell.frameHeight["explanation"]! + cell.frameHeight["button"]!))
        }
        

        animateExpandLabelConstraints(cell: cell, arrowPosition: .identity)
        cellHeightAnimation(tableView: tableView)
    }
    
    func collapseExplanationLabelAnimation(cell: NasaNewsEntryCell) {
        UIView.transition(with: cell.currentEntryExplanation, duration: 0.3, options: [.curveLinear], animations: { () -> Void in
            cell.currentEntryExplanation.numberOfLines = 7
        }, completion: nil)
    }

    //Setter Methods
    func animateExpandLabelConstraints(cell: NasaNewsEntryCell, arrowPosition: CGAffineTransform) {
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
