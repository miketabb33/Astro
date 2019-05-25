import UIKit

class PlanetCell: UITableViewCell {
    
    @IBOutlet weak var planetName: UILabel!
    
    @IBOutlet weak var planetCellImage: UIImageView!
    
    @IBOutlet weak var weightLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()

    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
}
