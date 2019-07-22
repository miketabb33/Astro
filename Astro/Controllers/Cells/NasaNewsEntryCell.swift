import UIKit

class NasaNewsEntryCell: UITableViewCell {
    let processUIComponents = NDNVCProcessing()
    let addConstraints = UIConstraints()
    
    var imageFrameHeight = CGFloat()
    var titleFrameHeight: CGFloat = 50
    
    let currentEntryTitle : UILabel = {
        let label = UILabel()
        label.font = UIFont (name: "Palatino", size: 20)
        label.textAlignment = .center
        label.numberOfLines = 0
        label.textColor = UIColor.black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var currentEntryExplanation = UILabel()
    
    var currentEntryImageView : UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        let margin = contentView.layoutMarginsGuide

        self.contentView.addSubview(currentEntryTitle)
        self.contentView.addSubview(currentEntryImageView)
        
        addConstraints.addConstraintForTopMostElementTo(currentEntryTitle, topAnchor: contentView.topAnchor, edges: margin, height: titleFrameHeight)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
