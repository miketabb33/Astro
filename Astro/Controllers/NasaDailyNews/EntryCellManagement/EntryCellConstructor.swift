import UIKit
import RealmSwift

class EntryCellConstructor {
    let addConstraints = UIConstraints()
    let entryImageManager = EntryImageProcessingManager()
    let expandExplanationManager = ExpandExplanationManager()
    let persistentData = PersistentData()
    
    func assignCell(cell: NasaNewsEntryCell, indexPath: IndexPath, allNasaEntries: Results<APODEntry>, tableView: UITableView, parent: UIViewController) {
        titleConfiguration(cell: cell, allNasaEntries: allNasaEntries, indexPath: indexPath)
        imageConfiguration(cell: cell, allNasaEntries: allNasaEntries, indexPath: indexPath)
        explanationConfiguration(cell: cell, allNasaEntries: allNasaEntries, indexPath: indexPath)
        expandButtonConfiguration(cell: cell, allNasaEntries: allNasaEntries, indexPath: indexPath, tableView: tableView, parent: parent)
        
        calculateCellHeightUnlessAlreadyCalculated(cell: cell, allNasaEntries: allNasaEntries, indexPath: indexPath)
    }
    
    //MARK: - Configure parts of entry cell
    func titleConfiguration(cell: NasaNewsEntryCell, allNasaEntries: Results<APODEntry>, indexPath: IndexPath) {
        cell.currentEntryTitle.text = allNasaEntries[indexPath.row].title
        addConstraints.addConstraintForTopMostElementTo(cell.currentEntryTitle, topAnchor: cell.contentView.topAnchor, edges: cell.contentView.layoutMarginsGuide, height: cell.frameHeight["title"]!)
    }
    
    func imageConfiguration(cell: NasaNewsEntryCell, allNasaEntries: Results<APODEntry>, indexPath: IndexPath) {
        cell.currentEntryImageView.image = UIImage(data: allNasaEntries[indexPath.row].image!)
        cell.currentEntryImageView = entryImageManager.processImage(currentCell: cell, stackUnder: cell.currentEntryTitle, edges: cell.contentView.safeAreaLayoutGuide)
    }
    
    func explanationConfiguration(cell: NasaNewsEntryCell, allNasaEntries: Results<APODEntry>, indexPath: IndexPath) {
        cell.currentEntryExplanation.text = allNasaEntries[indexPath.row].explanation
        expandExplanationManager.getTogglePositionOfExplanation(cell: cell, allNasaEntries: allNasaEntries, indexPath: indexPath)
    }
    
    func expandButtonConfiguration(cell: NasaNewsEntryCell, allNasaEntries: Results<APODEntry>, indexPath: IndexPath, tableView: UITableView, parent: UIViewController) {
        addConstraints.addStackingConstraintForButton(cell.currentExpandExplanationButton, stackUnder: cell.currentEntryExplanation, width: cell.frameHeight["button"]!, height: cell.frameHeight["button"]!, parentView: parent.view)
        
        cell.didTapExpandButton = {
            self.expandExplanationManager.toggleController(allNasaEntries: allNasaEntries, indexPath: indexPath, cell: cell, tableView: tableView)
        }
    }
    
    //MARK: - Calculate cell height
    func calculateCellHeightUnlessAlreadyCalculated(cell: NasaNewsEntryCell, allNasaEntries: Results<APODEntry>, indexPath: IndexPath) {
        if allNasaEntries[indexPath.row].cellHeight == 0 {
            try! persistentData.realm.write {
                allNasaEntries[indexPath.row].cellHeight = Int(Float(cell.frameHeight["title"]! + cell.frameHeight["image"]! + cell.frameHeight["explanation"]! + cell.frameHeight["button"]!))
            }
        }
    }
}
