import UIKit

class EntryCellManager {
    let entryCellInsertionManager = EntryCellInsertionManager()
    let entryCellConstructor = EntryCellConstructor()
    let persistentData = PersistentData()
    
    func addCell(cell: NasaNewsEntryCell, allNasaEntries: [NasaEntry], indexPath: IndexPath, tableView: UITableView, parent: UIViewController) {
        if allNasaEntries[indexPath.row].image == nil {
            if allNasaEntries[indexPath.row].url!.suffix(3) != "jpg" {
                saveAsYoutubeImage(indexPath: indexPath, allNasaEntries: allNasaEntries)
                entryCellConstructor.assignCell(cell: cell, indexPath: indexPath, allNasaEntries: allNasaEntries, tableView: tableView, parent: parent)
                entryCellInsertionManager.addNextEntryToPageUnlessInitialLoadComplete(tableView: tableView)
            } else {
                let imageUrlString = allNasaEntries[indexPath.row].url!
                let imageUrl:URL = URL(string: imageUrlString)!
                let imageData:NSData = NSData(contentsOf: imageUrl)!
                allNasaEntries[indexPath.row].image = imageData as Data
                persistentData.saveNasaEntries()
                entryCellConstructor.assignCell(cell: cell, indexPath: indexPath, allNasaEntries: allNasaEntries, tableView: tableView, parent: parent)
                entryCellInsertionManager.addNextEntryToPageUnlessInitialLoadComplete(tableView: tableView)
            }
        } else {
            entryCellConstructor.assignCell(cell: cell, indexPath: indexPath, allNasaEntries: allNasaEntries, tableView: tableView, parent: parent)
            entryCellInsertionManager.addNextEntryToPageUnlessInitialLoadComplete(tableView: tableView)
        }
    }
    
    func saveAsYoutubeImage(indexPath: IndexPath, allNasaEntries: [NasaEntry]) {
        allNasaEntries[indexPath.row].image = UIImage(named: "youtube")!.pngData()
        persistentData.saveNasaEntries()
    }
}
