import Foundation

class MathMethods {
    func findRelativeEnteredWeightInlbs(relativeWeight: Decimal, enteredWeight: Double) -> Decimal {
        return relativeWeight * Decimal(enteredWeight)
    }
}

