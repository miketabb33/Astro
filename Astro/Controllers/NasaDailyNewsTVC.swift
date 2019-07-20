import UIKit

class NasaDailyNewsTVC: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("yoo")
        
        tableView.register(UINib(nibName: "NasaNewsEntryCell", bundle: nil), forCellReuseIdentifier: "CustomNasaNewsEntryCell")
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CustomNasaNewsEntryCell", for: indexPath) as! NasaNewsEntryCell
        
        return cell
    }

}
