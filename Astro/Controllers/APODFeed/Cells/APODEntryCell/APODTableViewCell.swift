import UIKit

class APODTableViewCell: UITableViewCell {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var APODImageView: UIImageView!
    @IBOutlet weak var explanationLabel: UILabel!
    @IBOutlet weak var expandButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    @IBAction func expandButtonPressed(_ sender: Any) {
        
    }
    
}
