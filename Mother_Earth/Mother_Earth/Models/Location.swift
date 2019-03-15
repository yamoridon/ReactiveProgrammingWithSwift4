import CoreLocation
import Foundation

struct Location {
    enum LocationGeometryType {
        case position
        case point
        case polygon

        init?(string: String) {
            switch string {
            case "Point":
                self = .point
            case "Position":
                self = .position
            case "Polygon":
                self = .polygon
            default:
                return nil
            }
        }
    }

    let type: LocationGeometryType
    let date: Date?
    let coordinates: [CLLocationCoordinate2D]

    init?(json: [String: Any]) {
        guard
            let typeString = json["type"] as? String,
            let geoType = LocationGeometryType(string: typeString),
            let coords = json["coordinates"] as? [Any],
            (coords.count % 2) == 0 else
        {
            return nil
        }

        if let dateString = json["date"] as? String {
            date = EONETRequestRouter.dateFormatter.date(from: dateString)
        } else {
            date = nil
        }

        type = geoType
        coordinates = stride(from: 0, to: coords.count, by: 2).compactMap { index in
            guard
                let lat = coords[index] as? Double,
                let long = coords[index + 1] as? Double else
            {
                return nil
            }
            return CLLocationCoordinate2D(latitude: lat, longitude: long)
        }
    }
}
