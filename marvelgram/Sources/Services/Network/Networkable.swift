typealias JSONResponseHandler = (Result<Codable, NetworkError>) -> Void

protocol Networkable {
    func fetchConfig<T: Codable>(with urlString: String, of type: T.Type, completion: @escaping JSONResponseHandler)
    func fetch<T: Codable>(with urlString: String, of type: T.Type, completion: @escaping JSONResponseHandler)
}
