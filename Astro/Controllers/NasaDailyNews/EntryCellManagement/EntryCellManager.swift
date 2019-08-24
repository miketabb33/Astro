import UIKit

class EntryCellManager {
    let entryCellInsertionManager = EntryCellInsertionManager()
    let entryCellConstructor = EntryCellConstructor()
    let persistentData = PersistentData()
    
    func addNextCell(cell: NasaNewsEntryCell, allNasaEntries: [NasaEntry], indexPath: IndexPath, tableView: UITableView, parent: UIViewController) {
        if allNasaEntries[indexPath.row].image == nil {
            fetchImageAndRenderEntry(cell: cell, allNasaEntries: allNasaEntries, indexPath: indexPath, tableView: tableView, parent: parent)
        } else {
            renderEntry(cell: cell, allNasaEntries: allNasaEntries, indexPath: indexPath, tableView: tableView, parent: parent)
        }
    }
    
    //MARK: - Fetch Image Methods
    func fetchImageAndRenderEntry(cell: NasaNewsEntryCell, allNasaEntries: [NasaEntry], indexPath: IndexPath, tableView: UITableView, parent: UIViewController) {
        if allNasaEntries[indexPath.row].url!.suffix(3) != "jpg" {
            saveYouTubeImageUnlessPictureAndRenderEntry(cell: cell, allNasaEntries: allNasaEntries, indexPath: indexPath, tableView: tableView, parent: parent)
        } else {
            fetchImageFromInternetAndRenderEntry(cell: cell, allNasaEntries: allNasaEntries, indexPath: indexPath, tableView: tableView, parent: parent)
        }
    }
    
    func saveYouTubeImageUnlessPictureAndRenderEntry(cell: NasaNewsEntryCell, allNasaEntries: [NasaEntry], indexPath: IndexPath, tableView: UITableView, parent: UIViewController) {
        allNasaEntries[indexPath.row].image = UIImage(named: "youtube")!.pngData()
        persistentData.saveNasaEntries()
        renderEntry(cell: cell, allNasaEntries: allNasaEntries, indexPath: indexPath, tableView: tableView, parent: parent)
    }
    
    func fetchImageFromInternetAndRenderEntry(cell: NasaNewsEntryCell, allNasaEntries: [NasaEntry], indexPath: IndexPath, tableView: UITableView, parent: UIViewController) {
        let imageUrlString = allNasaEntries[indexPath.row].url!
        let imageUrl:URL = URL(string: imageUrlString)!
        let imageData:NSData = NSData(contentsOf: imageUrl)!
        allNasaEntries[indexPath.row].image = imageData as Data
        persistentData.saveNasaEntries()
        renderEntry(cell: cell, allNasaEntries: allNasaEntries, indexPath: indexPath, tableView: tableView, parent: parent)
    }
    
    //MARK: - Render Entry Method
    func renderEntry(cell: NasaNewsEntryCell, allNasaEntries: [NasaEntry], indexPath: IndexPath, tableView: UITableView, parent: UIViewController) {
        entryCellConstructor.assignCell(cell: cell, indexPath: indexPath, allNasaEntries: allNasaEntries, tableView: tableView, parent: parent)
        entryCellInsertionManager.addNextEntryToPageUnlessInitialLoadComplete(tableView: tableView)
    }
    
}
