import UIKit

protocol APODEntryCellDelegate {
    func didTapExpandButton(index: Int, cell: APODEntryCell)
}

class APODEntryCell: UITableViewCell {
    
    var delegate: APODEntryCellDelegate?
    var index: Int?
    
    var componentHeight: [String:CGFloat] = [
        "image": 0,
        "title": APODEntryComponentDefaultHeights().title,
        "explanation": APODEntryComponentDefaultHeights().explanation,
        "button": APODEntryComponentDefaultHeights().button
    ]
    
    let expandButton: UIButton = {
        let button = UIButton()
        button.titleLabel?.font = UIFont(name: "Palatino", size: 20)
        button.setImage(UIImage(named: "down-arrow"), for: .normal)
        button.tintColor = UIColor.gray
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    let title: UILabel = {
        let label = UILabel()
        label.font = UIFont (name: "Palatino", size: 20)
        label.textAlignment = .center
        label.numberOfLines = 0
        label.textColor = UIColor.black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var explanation: UILabel = {
        let label = UILabel()
        label.font = UIFont (name: "Palatino", size: 14)
        label.numberOfLines = 7
        label.lineBreakMode = NSLineBreakMode.byTruncatingTail
        label.textColor = UIColor.black
        label.backgroundColor = UIColor.clear
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var APODImage: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.addSubview(title)
        contentView.addSubview(APODImage)
        contentView.addSubview(explanation)
        contentView.addSubview(expandButton)
        
        expandButton.addTarget(self, action: #selector(expandButtonPressed), for: .touchUpInside)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func expandButtonPressed() {
        delegate?.didTapExpandButton(index: index!, cell: self)
    }

}
