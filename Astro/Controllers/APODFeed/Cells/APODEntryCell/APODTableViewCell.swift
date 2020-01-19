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
    
    @IBOutlet weak var APODImageViewHeightConstraint: NSLayoutConstraint!
    
    var delegate: APODTableViewCellDelegate?
    var index: Int?
    
    var cellHeight: APODCellHeight?
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    @IBAction func expandButtonPressed(_ sender: Any) {
        delegate?.didTapExpandButton(cell: self)
    }
    
    
    
    
    func setCellData(entry: APODEntry) {
        titleLabel.text = entry.contents.title
        explanationLabel.text = entry.contents.explanation
        configureImage(entry: entry)
        
        cellHeight = APODCellHeight(titleHeight: titleLabel.frame.height, imageHeight: CGFloat(entry.feedData.imageHeight), explanationHeight: explanationLabel.frame.height, buttonViewHeight: expandButtonView.frame.height)
    }
    
    func configureImage(entry: APODEntry) {
        let image = UIImage(data: entry.feedData.image)!
        
        APODImageView.image = image
        APODImageViewHeightConstraint.constant = CGFloat(entry.feedData.imageHeight)
        APODImageView.contentMode = ImageProcessing(image: image).getContentMode()
    }
    
    class APODCellHeight {
        var titleHeight: CGFloat
        var imageHeight: CGFloat
        var explanationHeight: CGFloat
        var buttonViewHeight: CGFloat
        
        init(titleHeight: CGFloat, imageHeight: CGFloat, explanationHeight: CGFloat, buttonViewHeight: CGFloat) {
            self.titleHeight = titleHeight
            self.imageHeight = imageHeight
            self.explanationHeight = explanationHeight
            self.buttonViewHeight = buttonViewHeight
        }
        
        func getCellHeight() -> CGFloat {
            return titleHeight + imageHeight + explanationHeight + buttonViewHeight
        }
        
    }
    
//    func getTogglePositionOfExplanation(cell: APODEntryCell, entry: APODEntry) {
//        var explanationHeight: CGFloat = 0
//        if entry.feedData.expandEnabled == true {
//            explanationHeight = cell.explanation.frame.height
//
//            showExplanation(cell: cell, numberOfLines: 0, height: explanationHeight, arrowPosition: CGAffineTransform(rotationAngle: .pi))
//        } else {
//            explanationHeight = cell.componentHeight["explanation"]!
//            
//            showExplanation(cell: cell, numberOfLines: 7, height: explanationHeight, arrowPosition: .identity)
//        }
//    }
//
//    func showExplanation(cell: APODEntryCell, numberOfLines: Int, height: CGFloat, arrowPosition: CGAffineTransform) {
//        cell.expandButton.transform = arrowPosition
//        cell.explanation.numberOfLines = numberOfLines
//        addStackingConstraintTo(cell.explanation, stackUnder: cell.APODImage, edges: cell.contentView.layoutMarginsGuide, height: height)
//    }
    
}
