import Foundation

public func executeProceduer(for description: String, procedure: () -> Void) {
    print("Procedure executed for:", description)
    procedure()
}

