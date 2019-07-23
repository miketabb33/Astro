import UIKit

class NasaNewsEntryCell: UITableViewCell {
    
    var frameHeight: [String:CGFloat] = [
        "image": 0,
        "title": 50,
        "explanation": 120
    ]
    
    let currentEntryTitle : UILabel = {
        let label = UILabel()
        label.font = UIFont (name: "Palatino", size: 20)
        label.textAlignment = .center
        label.numberOfLines = 0
        label.textColor = UIColor.black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var currentEntryExplanation : UILabel = {
        let label = UILabel()
        label.font = UIFont (name: "Palatino", size: 14)
        label.numberOfLines = 0
        label.textColor = UIColor.black
        label.backgroundColor = UIColor.clear
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var currentEntryImageView : UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        contentView.addSubview(currentEntryTitle)
        contentView.addSubview(currentEntryImageView)
        contentView.addSubview(currentEntryExplanation)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
