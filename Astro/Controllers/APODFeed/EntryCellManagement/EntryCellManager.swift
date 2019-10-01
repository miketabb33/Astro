import UIKit
import RealmSwift

class EntryCellManager {
    let entryCellInsertionManager = EntryCellInsertionManager()
    
    func addNextCell(cell: APODEntryCell, allAPODEntries: Results<APODEntry>, indexPath: IndexPath, tableView: UITableView, parent: UIViewController) {
        if allAPODEntries[indexPath.row].image == nil {
            fetchImageAndRenderEntry(cell: cell, allAPODEntries: allAPODEntries, indexPath: indexPath, tableView: tableView, parent: parent)
        } else {
            renderEntry(cell: cell, allAPODEntries: allAPODEntries, indexPath: indexPath, tableView: tableView, parent: parent)
        }
    }
    
    //MARK: - Fetch Image Methods
    func fetchImageAndRenderEntry(cell: APODEntryCell, allAPODEntries: Results<APODEntry>, indexPath: IndexPath, tableView: UITableView, parent: UIViewController) {
        if allAPODEntries[indexPath.row].url.suffix(3) != "jpg" {
            saveYouTubeImageUnlessPictureAndRenderEntry(cell: cell, allAPODEntries: allAPODEntries, indexPath: indexPath, tableView: tableView, parent: parent)
        } else {
            fetchImageFromInternetAndRenderEntry(cell: cell, allAPODEntries: allAPODEntries, indexPath: indexPath, tableView: tableView, parent: parent)
        }
    }
    
    func saveYouTubeImageUnlessPictureAndRenderEntry(cell: APODEntryCell, allAPODEntries: Results<APODEntry>, indexPath: IndexPath, tableView: UITableView, parent: UIViewController) {
        try! RealmMethods().realm.write {
            allAPODEntries[indexPath.row].image = UIImage(named: "youtube")!.pngData()
        }
        renderEntry(cell: cell, allAPODEntries: allAPODEntries, indexPath: indexPath, tableView: tableView, parent: parent)
    }
    
    func fetchImageFromInternetAndRenderEntry(cell: APODEntryCell, allAPODEntries: Results<APODEntry>, indexPath: IndexPath, tableView: UITableView, parent: UIViewController) {
        let imageUrlString = allAPODEntries[indexPath.row].url
        let imageUrl:URL = URL(string: imageUrlString)!
        let imageData:NSData = NSData(contentsOf: imageUrl)!
        try! RealmMethods().realm.write {
            allAPODEntries[indexPath.row].image = imageData as Data
        }
        renderEntry(cell: cell, allAPODEntries: allAPODEntries, indexPath: indexPath, tableView: tableView, parent: parent)
    }
    
    //MARK: - Render Entry Method
    func renderEntry(cell: APODEntryCell, allAPODEntries: Results<APODEntry>, indexPath: IndexPath, tableView: UITableView, parent: UIViewController) {
        EntryCellConstructor().assignCell(cell: cell, indexPath: indexPath, allAPODEntries: allAPODEntries, tableView: tableView, parent: parent)
        entryCellInsertionManager.addNextEntryToPageUnlessInitialLoadComplete(tableView: tableView)
    }
    
}
