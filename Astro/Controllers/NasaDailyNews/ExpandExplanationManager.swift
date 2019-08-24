import UIKit

class ExpandExplanationManager {
    let addConstraints = UIConstraints()
    let persistentData = PersistentData()
    
    func toggleController(allNasaEntries: [NasaEntry], indexPath: IndexPath, cell: NasaNewsEntryCell, tableView: UITableView) {
        if allNasaEntries[indexPath.row].expandEnabled == false {
            expandExplanationLabel(allNasaEntries: allNasaEntries, indexPath: indexPath, cell: cell, tableView: tableView)
        } else {
            collapseExplanationLabel(allNasaEntries: allNasaEntries, indexPath: indexPath, cell: cell, tableView: tableView)
        }
    }
    
    
    
    //MARK: - Expand Explanation Label
    func expandExplanationLabel(allNasaEntries: [NasaEntry], indexPath: IndexPath, cell: NasaNewsEntryCell, tableView: UITableView) {
        allNasaEntries[indexPath.row].expandEnabled = true
        expandExplanationLabalAnimation(cell: cell)
        addConstraints.addStackingConstraintTo(cell.currentEntryExplanation, stackUnder: cell.currentEntryImageView, edges: cell.contentView.layoutMarginsGuide, height: self.getExpandedEntryExplanationFrameHeight(rawFrameHeight: cell.currentEntryExplanation.frame.height))
        allNasaEntries[indexPath.row].cellHeight = Float(cell.frameHeight["title"]! + cell.frameHeight["image"]! + getExpandedEntryExplanationFrameHeight(rawFrameHeight: cell.currentEntryExplanation.frame.height) + cell.frameHeight["button"]!)
        persistentData.saveNasaEntries()
        animateExpandLabelConstraints(cell: cell, arrowPosition: CGAffineTransform(rotationAngle: .pi))
        cellHeightAnimation(tableView: tableView)
    }
    
    func expandExplanationLabalAnimation(cell: NasaNewsEntryCell) {
        UIView.transition(with: cell.currentEntryExplanation, duration: 0.3, options: [.curveLinear], animations: { () -> Void in
            cell.currentEntryExplanation.numberOfLines = 0
            cell.currentEntryExplanation.sizeToFit()
        }, completion: nil)
    }
    
    //MARK: - Collapse Explanation Label
    func collapseExplanationLabel(allNasaEntries: [NasaEntry], indexPath: IndexPath, cell: NasaNewsEntryCell, tableView: UITableView) {
        allNasaEntries[indexPath.row].expandEnabled = false
        collapseExplanationLabelAnimation(cell: cell)
        addConstraints.addStackingConstraintTo(cell.currentEntryExplanation, stackUnder: cell.currentEntryImageView, edges: cell.contentView.layoutMarginsGuide, height: cell.frameHeight["explanation"]!)
        allNasaEntries[indexPath.row].cellHeight = Float(cell.frameHeight["title"]! + cell.frameHeight["image"]! + cell.frameHeight["explanation"]! + cell.frameHeight["button"]!)
        persistentData.saveNasaEntries()
        animateExpandLabelConstraints(cell: cell, arrowPosition: .identity)
        cellHeightAnimation(tableView: tableView)
    }
    
    func collapseExplanationLabelAnimation(cell: NasaNewsEntryCell) {
        UIView.transition(with: cell.currentEntryExplanation, duration: 0.3, options: [.curveLinear], animations: { () -> Void in
            cell.currentEntryExplanation.numberOfLines = 7
        }, completion: nil)
    }

    //MARK: - Bitoggle Methods
    func getExpandedEntryExplanationFrameHeight(rawFrameHeight: CGFloat) -> CGFloat {
        return rawFrameHeight + 10
    }
    
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
}
