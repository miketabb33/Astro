import UIKit
import RealmSwift

class EntryCellConstructor {
    let addConstraints = EntryCellConstraints()
    let expandExplanationManager = ExpandExplanationManager()
    
    func assignCell(cell: APODEntryCell, indexPath: IndexPath, allAPODEntries: Results<APODEntry>, tableView: UITableView, parent: UIViewController) {
        titleConfiguration(cell: cell, allAPODEntries: allAPODEntries, indexPath: indexPath)
        imageConfiguration(cell: cell, allAPODEntries: allAPODEntries, indexPath: indexPath)
        explanationConfiguration(cell: cell, allAPODEntries: allAPODEntries, indexPath: indexPath)
        expandButtonConfiguration(cell: cell, allAPODEntries: allAPODEntries, indexPath: indexPath, tableView: tableView, parent: parent)
        
        calculateCellHeightUnlessAlreadyCalculated(cell: cell, allAPODEntries: allAPODEntries, indexPath: indexPath)
    }
    
    //MARK: - Configure parts of entry cell
    func titleConfiguration(cell: APODEntryCell, allAPODEntries: Results<APODEntry>, indexPath: IndexPath) {
        cell.currentEntryTitle.text = allAPODEntries[indexPath.row].title
        addConstraints.addConstraintForTopMostElementTo(cell.currentEntryTitle, topAnchor: cell.contentView.topAnchor, edges: cell.contentView.layoutMarginsGuide, height: cell.frameHeight["title"]!)
    }
    
    func imageConfiguration(cell: APODEntryCell, allAPODEntries: Results<APODEntry>, indexPath: IndexPath) {
        cell.currentEntryImageView.image = UIImage(data: allAPODEntries[indexPath.row].image!)
        cell.currentEntryImageView = EntryImageProcessingManager().processImage(currentCell: cell, stackUnder: cell.currentEntryTitle, edges: cell.contentView.safeAreaLayoutGuide)
    }
    
    func explanationConfiguration(cell: APODEntryCell, allAPODEntries: Results<APODEntry>, indexPath: IndexPath) {
        cell.currentEntryExplanation.text = allAPODEntries[indexPath.row].explanation
        expandExplanationManager.getTogglePositionOfExplanation(cell: cell, allAPODEntries: allAPODEntries, indexPath: indexPath)
    }
    
    func expandButtonConfiguration(cell: APODEntryCell, allAPODEntries: Results<APODEntry>, indexPath: IndexPath, tableView: UITableView, parent: UIViewController) {
        addConstraints.addStackingConstraintForButton(cell.currentExpandExplanationButton, stackUnder: cell.currentEntryExplanation, width: cell.frameHeight["button"]!, height: cell.frameHeight["button"]!, parentView: parent.view)
        
        cell.didTapExpandButton = {
            self.expandExplanationManager.toggleController(allAPODEntries: allAPODEntries, indexPath: indexPath, cell: cell, tableView: tableView)
        }
    }
    
    //MARK: - Calculate cell height
    func calculateCellHeightUnlessAlreadyCalculated(cell: APODEntryCell, allAPODEntries: Results<APODEntry>, indexPath: IndexPath) {
        if allAPODEntries[indexPath.row].cellHeight == 0 {
            try! RealmMethods().realm.write {
                allAPODEntries[indexPath.row].cellHeight = Int(Float(cell.frameHeight["title"]! + cell.frameHeight["image"]! + cell.frameHeight["explanation"]! + cell.frameHeight["button"]!))
            }
        }
    }
}
