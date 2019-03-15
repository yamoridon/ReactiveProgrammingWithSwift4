import Foundation

enum EONETError: Error {
    case invalidURL(String)
    case invalidParameter(String, Any)
    case invalidJSON(String)
}
