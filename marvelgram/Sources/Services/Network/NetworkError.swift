import Foundation

enum NetworkError: Error {
    case dataIsNil
    case invalidURL
    case invalidData
    case decodingError
    case badResponse(URLResponse?)
}
