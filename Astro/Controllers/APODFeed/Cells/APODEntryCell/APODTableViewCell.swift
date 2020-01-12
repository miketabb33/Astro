import UIKit

protocol APODTableViewCellDelegate {
    func didTapExpandButton(cell: APODTableViewCell)
}

class APODTableViewCell: UITableViewCell {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var APODImageView: UIImageView!
    @IBOutlet weak var explanationLabel: UILabel!
    @IBOutlet weak var expandButton: UIButton!
    
    var delegate: APODTableViewCellDelegate?
    var index: Int?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    @IBAction func expandButtonPressed(_ sender: Any) {
        delegate?.didTapExpandButton(cell: self)
    }
    
}
