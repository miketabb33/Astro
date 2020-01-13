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
        configureImage(imageData: entry.feedData.image)
        explanationLabel.text = entry.contents.explanation
    }
    
    func configureImage(imageData: Data) {
        let image = UIImage(data: imageData)!
        
        APODImageView.image = image
        APODImageView.contentMode = ImageProcessing(image: image).getContentMode()
        
        let imageHeight = ImageProcessing(image: image).getImageDisplayHeight()
        APODImageView.heightAnchor.constraint(equalToConstant: imageHeight).isActive = true
    }
    
    func getCellHeight() -> CGFloat {
        let titleHeight = titleLabel.frame.height
        let imageHeight = APODImageView.frame.height
        let explanationHeight = explanationLabel.frame.height
        let expandButtonViewHeight = expandButtonView.frame.height
        
        let sum = titleHeight + imageHeight + explanationHeight + expandButtonViewHeight
        return sum
    }
    
}
