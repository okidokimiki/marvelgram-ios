typealias JSONResponseHandler = (Result<Codable, NetworkError>) -> Void

protocol Networkable {
    func fetch<T: Codable>(with urlString: String, of type: T.Type, completion: @escaping JSONResponseHandler)
}
