import UIKit

class UIConstraints {
    func addStackingConstraintTo(_ element: UIView, stackUnder topElement: UIView, edges: UILayoutGuide, height: CGFloat) {
        element.removeConstraints(element.constraints)
        NSLayoutConstraint.activate([
            element.topAnchor.constraint(equalToSystemSpacingBelow: topElement.bottomAnchor, multiplier: 0),
            element.leadingAnchor.constraint(equalTo: edges.leadingAnchor),
            element.trailingAnchor.constraint(equalTo: edges.trailingAnchor),
            element.heightAnchor.constraint(equalToConstant: height)
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
}
