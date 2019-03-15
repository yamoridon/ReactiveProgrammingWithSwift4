import Foundation

struct Event {
    // swiftlint:disable:next identifier_name
    let id: String
    let title: String
    let description: String
    let link: URL?
    let closeDate: Date?
    let categories: [Int]
    let locations: [Location]

    init?(json: [String: Any]) {
        guard
            // swiftlint:disable:next identifier_name
            let id = json["id"] as? String,
            let title = json["title"] as? String,
            let description = json["description"] as? String,
            let link = json["link"] as? String,
            let closeDate = json["closed"] as? String,
            let categories = json["categories"] as? [[String: Any]] else
        {
            return nil
        }

        self.id = id
        self.title = title
        self.description = description
        self.link = URL(string: link)
        self.closeDate = EONETRequestRouter.dateFormatter.date(from: closeDate)
        self.categories = categories.compactMap { categoryDesc in
            guard let catID = categoryDesc["id"] as? Int else {
                return nil
            }
            return catID
        }

        if let geometires = json["geometries"] as? [[String: Any]] {
            locations = geometires.compactMap(Location.init)
        } else {
            locations = []
        }
    }

    static func compareDates(lhs: Event, rhs: Event) -> Bool {
        switch (lhs.closeDate, rhs.closeDate) {
        case (nil, nil): return false
        case (nil, _): return true
        case (_, nil): return false
        case let (ldate, rdate): return ldate! < rdate!
        }
    }
}
