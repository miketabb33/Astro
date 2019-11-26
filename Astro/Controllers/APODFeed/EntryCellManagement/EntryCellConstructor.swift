import UIKit

class EntryCellConstructor {
    let addConstraints = EntryCellConstraints()
    
    func assignCell(cell: APODEntryCell, entry: APODEntryModel, tableView: UITableView, parent: UIViewController) {
        titleConfiguration(cell: cell, entry: entry)
        imageConfiguration(cell: cell, entry: entry)
        explanationConfiguration(cell: cell, entry: entry)
        expandButtonConfiguration(cell: cell, entry: entry, tableView: tableView, parent: parent)
    }
    
    //MARK: - Configure parts of entry cell
    func titleConfiguration(cell: APODEntryCell, entry: APODEntryModel) {
        cell.currentEntryTitle.text = entry.title
        addConstraints.addConstraintForTopMostElementTo(cell.currentEntryTitle, topAnchor: cell.contentView.topAnchor, edges: cell.contentView.layoutMarginsGuide, height: cell.frameHeight["title"]!)
    }
    
    func imageConfiguration(cell: APODEntryCell, entry: APODEntryModel) {
        cell.currentEntryImageView.image = UIImage(data: entry.image!)
        cell.currentEntryImageView = EntryImageProcessingManager().processImage(currentCell: cell, stackUnder: cell.currentEntryTitle, edges: cell.contentView.safeAreaLayoutGuide)
    }
    
    func explanationConfiguration(cell: APODEntryCell, entry: APODEntryModel) {
        cell.currentEntryExplanation.text = entry.explanation
        ExpandExplanationManager().getTogglePositionOfExplanation(cell: cell, entry: entry)
    }
    
    func expandButtonConfiguration(cell: APODEntryCell, entry: APODEntryModel, tableView: UITableView, parent: UIViewController) {
        addConstraints.addStackingConstraintForButton(cell.currentExpandExplanationButton, stackUnder: cell.currentEntryExplanation, width: cell.frameHeight["button"]!, height: cell.frameHeight["button"]!, parentView: parent.view)
    }
    
}
