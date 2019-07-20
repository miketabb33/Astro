import UIKit

class NasaNewsEntryCell: UITableViewCell {
    let processUIComponents = NDNVCProcessing()
    let addConstraints = UIConstraints()
    
    let currentEntryTitle:UILabel = {
        let label = UILabel()
        label.font = UIFont (name: "Palatino", size: 20)
        label.textAlignment = .center
        label.numberOfLines = 0
        label.textColor = UIColor.black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    
    var currentEntryExplanation = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        let margin = contentView.layoutMarginsGuide

        self.contentView.addSubview(currentEntryTitle)
        
        addConstraints.addConstraintForTopMostElementTo(currentEntryTitle, topAnchor: contentView.topAnchor, edges: margin, height: 50)

        
        currentEntryTitle.topAnchor.constraint(equalTo:self.contentView.topAnchor).isActive = true
//        currentEntryTitle.leadingAnchor.constraint(equalTo:self.contentView.trailingAnchor, constant:10).isActive = true
//        currentEntryTitle.trailingAnchor.constraint(equalTo:self.contentView.trailingAnchor, constant:-10).isActive = true
//        currentEntryTitle.heightAnchor.constraint(equalToConstant:40).isActive = true

        
        
        //contentView.addSubview(currentEntryExplanation)
        //currentEntryExplanation = processUIComponents.processExplanation(currentEntryExplanation, stackUnder: currentEntryTitle, edges: margin)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
