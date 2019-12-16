import UIKit

class EntryCellConstraints {
    
    func addStackingConstraintTo(_ element: UIView, stackUnder topElement: UIView, edges: UILayoutGuide, height: CGFloat) {
        element.removeConstraints(element.constraints)
        NSLayoutConstraint.activate([
            element.topAnchor.constraint(equalToSystemSpacingBelow: topElement.bottomAnchor, multiplier: 0),
            element.leadingAnchor.constraint(equalTo: edges.leadingAnchor),
            element.trailingAnchor.constraint(equalTo: edges.trailingAnchor),
            element.heightAnchor.constraint(equalToConstant: height)
        ])
    }
    
    func addStackingConstraintForButton(_ element: UIView, stackUnder topElement: UIView, width: CGFloat, height: CGFloat, parentView: UIView) {
        element.removeConstraints(element.constraints)
        NSLayoutConstraint.activate([
            element.topAnchor.constraint(equalTo: topElement.bottomAnchor, constant: 0),
            element.widthAnchor.constraint(equalToConstant: width),
            element.heightAnchor.constraint(equalToConstant: height),
            element.centerXAnchor.constraint(equalTo: parentView.centerXAnchor, constant: 0)
            ])
    }
    
    func addConstraintForTopMostElementTo(_ element: UIView, topAnchor: NSLayoutYAxisAnchor, edges: UILayoutGuide, height: CGFloat) {
        element.removeConstraints(element.constraints)
        NSLayoutConstraint.activate([
            element.topAnchor.constraint(equalTo: topAnchor),
            element.leadingAnchor.constraint(equalTo: edges.leadingAnchor),
            element.trailingAnchor.constraint(equalTo: edges.trailingAnchor),
            element.heightAnchor.constraint(equalToConstant: height)
            ])
    }
    
    
    func getTogglePositionOfExplanation(cell: APODEntryCell, entry: APODEntry) {
        var explanationHeight: CGFloat = 0
        if entry.feedData.expandEnabled == true {
            explanationHeight = cell.explanation.frame.height
            
            showExplanation(cell: cell, numberOfLines: 0, height: explanationHeight, arrowPosition: CGAffineTransform(rotationAngle: .pi))
        } else {
            explanationHeight = cell.componentHeight["explanation"]!
            
            showExplanation(cell: cell, numberOfLines: 7, height: explanationHeight, arrowPosition: .identity)
        }
    }
    
    func showExplanation(cell: APODEntryCell, numberOfLines: Int, height: CGFloat, arrowPosition: CGAffineTransform) {
        cell.expandButton.transform = arrowPosition
        cell.explanation.numberOfLines = numberOfLines
        addStackingConstraintTo(cell.explanation, stackUnder: cell.APODImage, edges: cell.contentView.layoutMarginsGuide, height: height)
    }
}
