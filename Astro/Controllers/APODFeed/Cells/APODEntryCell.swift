import UIKit

class APODEntryCell: UITableViewCell {
    
    var frameHeight: [String:CGFloat] = [
        "image": 0,
        "title": 50,
        "explanation": 120,
        "button": 20
    ]
    
    let currentExpandExplanationButton : UIButton = {
        let button = UIButton()
        button.titleLabel?.font = UIFont(name: "Palatino", size: 20)
        button.setImage(UIImage(named: "down-arrow"), for: .normal)
        button.tintColor = UIColor.gray
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
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
        label.numberOfLines = 7
        label.lineBreakMode = NSLineBreakMode.byTruncatingTail
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
        contentView.addSubview(currentExpandExplanationButton)
        
        currentExpandExplanationButton.addTarget(self, action: #selector(expandButtonPressed), for: .touchUpInside)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func expandButtonPressed() {
        didTapExpandButton()
    }
    
    var didTapExpandButton: () -> () = {
        fatalError("Button was not assinged a function")
    }
    

}
