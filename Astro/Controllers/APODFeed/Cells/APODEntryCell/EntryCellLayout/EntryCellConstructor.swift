import UIKit

class EntryCellConstructor {
    let addConstraints = EntryCellConstraints()
    
    func assignCell(cell: APODEntryCell, entry: APODEntry, tableView: UITableView, parent: UIViewController) {
        titleConfiguration(cell: cell, entry: entry)
        imageConfiguration(cell: cell, entry: entry)
        explanationConfiguration(cell: cell, entry: entry)
        expandButtonConfiguration(cell: cell, parent: parent)
    }
    
    //MARK: - Configure parts of entry cell
    func titleConfiguration(cell: APODEntryCell, entry: APODEntry) {
        cell.title.text = entry.contents.title
        addConstraints.addConstraintForTopMostElementTo(cell.title, topAnchor: cell.contentView.topAnchor, edges: cell.contentView.layoutMarginsGuide, height: cell.componentHeight["title"]!)
    }
    
    func imageConfiguration(cell: APODEntryCell, entry: APODEntry) {
        let image = UIImage(data: entry.feedData.image)!
        cell.APODImage.image = image
        cell.APODImage = ImageProcessing(image: image).getImageRatioAndFit(currentCell: cell, stackUnder: cell.title, edges: cell.contentView.safeAreaLayoutGuide)
    }
    
    func explanationConfiguration(cell: APODEntryCell, entry: APODEntry) {
        cell.explanation.text = entry.contents.explanation
        addConstraints.getTogglePositionOfExplanation(cell: cell, entry: entry)
    }
    
    func expandButtonConfiguration(cell: APODEntryCell, parent: UIViewController) {
        addConstraints.addStackingConstraintForButton(cell.expandButton, stackUnder: cell.explanation, width: cell.componentHeight["button"]!, height: cell.componentHeight["button"]!, parentView: parent.view)
    }
    
}
