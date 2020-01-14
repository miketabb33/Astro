import UIKit

protocol APODTableViewCellDelegate {
    func didTapExpandButton(cell: APODTableViewCell)
}

class APODTableViewCell: UITableViewCell {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var APODImageView: UIImageView!
    @IBOutlet weak var explanationLabel: UILabel!
    @IBOutlet weak var expandButton: UIButton!
    @IBOutlet weak var expandButtonView: UIView!
    
    var delegate: APODTableViewCellDelegate?
    var index: Int?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    @IBAction func expandButtonPressed(_ sender: Any) {
        delegate?.didTapExpandButton(cell: self)
    }
    
    
    func setCellData(entry: APODEntry) {
        titleLabel.text = entry.contents.title
        explanationLabel.text = entry.contents.explanation
        
        let image = UIImage(data: entry.feedData.image)!
        
        APODImageView.image = image
        
        let imageHeight = CGFloat(entry.feedData.imageHeight)
        let constraint = APODImageView.heightAnchor.constraint(equalToConstant: imageHeight)
            
        constraint.priority = UILayoutPriority(rawValue: 1)
        constraint.isActive = true
        
        APODImageView.contentMode = ImageProcessing(image: image).getContentMode()
    }
    
}
