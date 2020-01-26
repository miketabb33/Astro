import UIKit

protocol APODTableViewCellDelegate {
    func didTapExpandButton(index: Int, explanationLabel: UILabel, expandButton: UIButton, explanationHeightConstraint: NSLayoutConstraint)
}

class APODTableViewCell: UITableViewCell {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var APODImageView: UIImageView!
    @IBOutlet weak var explanationLabel: UILabel!
    @IBOutlet weak var expandButton: UIButton!
    @IBOutlet weak var expandButtonView: UIView!
    
    @IBOutlet weak var titleHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var imageHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var explanationHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var expandButtonViewHeightConstraint: NSLayoutConstraint!
    
    var delegate: APODTableViewCellDelegate?
    var index: Int?

    @IBAction func expandButtonPressed(_ sender: Any) {
        delegate?.didTapExpandButton(index: index!, explanationLabel: explanationLabel, expandButton: expandButton, explanationHeightConstraint: explanationHeightConstraint)
    }
    
    
    func setCellData(entry: APODEntry) {
        configureTitle(text: entry.contents.title, height: entry.feedData.cellHeight.title)
        configureImage(imageData: entry.feedData.image, height: entry.feedData.cellHeight.image)
        configureExplanation(text: entry.contents.explanation, height: entry.feedData.cellHeight.explanation)
        configureExpandButtonView(height: entry.feedData.cellHeight.expandButtonView)
    }
    
    func configureTitle(text: String, height: CGFloat) {
        titleLabel.text = text
        titleHeightConstraint.constant = height
    }
    
    func configureImage(imageData: Data, height: CGFloat) {
        let image = UIImage(data: imageData)!
        
        APODImageView.image = image
        imageHeightConstraint.constant = height
        APODImageView.contentMode = ImageProcessing(image: image).getContentMode()
    }
    
    func configureExplanation(text: String, height: CGFloat) {
        explanationLabel.text = text
        explanationHeightConstraint.constant = height
    }
    
    func configureExpandButtonView(height: CGFloat) {
        expandButtonViewHeightConstraint.constant = height
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
