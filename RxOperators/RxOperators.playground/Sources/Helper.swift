import Foundation
import RxSwift

public func executeProcedure(for description: String, procedure: () -> Void) {
    print("Procedure execute for:", description)
    procedure()
}
