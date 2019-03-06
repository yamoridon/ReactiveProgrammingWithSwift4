import RxSwift
import UIKit

public func executeProcedure(for description: String, procedure: () -> Void) {
    print("Procedure execute for:", description)
    procedure()
}
