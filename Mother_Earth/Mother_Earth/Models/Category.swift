import Foundation

struct Category: Equatable {
    // swiftlint:disable:next identifier_name
    let id: Int
    let name: String
    let description: String
    let apiEndPoint: String
    var events = [Event]()

    init?(json: [String: Any]) {
        guard
            // swiftlint:disable:next identifier_name
            let id = json["id"] as? Int,
            let name = json["title"] as? String,
            let description = json["description"] as? String else
        {
            return nil
        }

        self.id = id
        self.name = name
        self.description = description
        self.apiEndPoint = "\(EONETRequestRouter.categoriesEndPoint)/\(id)"
    }

    // MARK: - Equatable
    static func == (lhs: Category, rhs: Category) -> Bool {
        return lhs.id == rhs.id
    }
}
