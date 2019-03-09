import Foundation
import RxSwift

public func executeProcedure(for description: String, procedure: () -> Void) {
    print("Procedure execute for:", description)
    procedure()
}

public extension Int {
    func isPrimse() -> Bool {
        guard self > 1 else { return false }

        var isPrimeFlag = true

        for index in 2..<self {
            if self % index == 0 {
                isPrimeFlag = false
            }
        }
        return isPrimeFlag
    }
}
