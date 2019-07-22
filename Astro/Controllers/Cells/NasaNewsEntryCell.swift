import UIKit

class NasaNewsEntryCell: UITableViewCell {
    let processUIComponents = NDNVCProcessing()
    let addConstraints = UIConstraints()
    
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
        let safeArea = contentView.safeAreaLayoutGuide
        
        

        self.contentView.addSubview(currentEntryTitle)
        self.contentView.addSubview(currentEntryImageView)
        
        addConstraints.addConstraintForTopMostElementTo(currentEntryTitle, topAnchor: contentView.topAnchor, edges: margin, height: 50)
        
        //addConstraints.addStackingConstraintTo(currentEntryImageView, stackUnder: currentEntryTitle, edges: safeArea, height: 240)
        //currentEntryImageView = processUIComponents.processImage(currentEntryImageView, stackUnder: currentEntryTitle, edges: safeArea)
        
        //contentView.addSubview(currentEntryExplanation)
        //currentEntryExplanation = processUIComponents.processExplanation(currentEntryExplanation, stackUnder: currentEntryTitle, edges: margin)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
