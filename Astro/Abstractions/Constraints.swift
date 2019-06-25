import UIKit

class Constaints {
    func addStackingConstraintTo(_ element: UIView, stackUnder topElement: UIView, edges: UILayoutGuide, height: CGFloat) {
        NSLayoutConstraint.activate([
            element.topAnchor.constraint(equalToSystemSpacingBelow: topElement.bottomAnchor, multiplier: 0),
            element.leadingAnchor.constraint(equalTo: edges.leadingAnchor),
            element.trailingAnchor.constraint(equalTo: edges.trailingAnchor),
            element.heightAnchor.constraint(equalToConstant: height)
        ])
    }
}
