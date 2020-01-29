import UIKit

class MainTabController: UITabBarController {
    var entryNetworking: EntryNetworking? = EntryNetworking()
    var entryImageNetworking: EntryImageNetworking? = EntryImageNetworking()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //select which tab is displayed upon opening app.
        selectedViewController = self.viewControllers?[0]
        
        entryNetworking!.SyncronizeAPODEntries()
        saveImagesAndHeightWhenReady()
    }
    
}

extension MainTabController {
    func saveImagesAndHeightWhenReady() {
        Notifier().await(onComplete: completed, updateConditional: updateConditional)
    }
    
    func completed() {
        entryImageNetworking!.saveImagesAndCellHeight(startingIndex: 0, amount: FeedSettings().amountToShow)
        entryNetworking = nil
    }
    
    func updateConditional() -> Bool {
        return entryNetworking!.imagesReadyForDownload
    }
}
