struct Hero: Codable {
    var id: Int
    let name: String
    let description: String
    let modified: String
    let thumbnail: Thumbnail
}

struct Thumbnail: Codable {
    let path: String
    let `extension`: String
}

extension Thumbnail {
    var url: String { "\(path).\(`extension`)" }
}
