import Foundation

struct RepositoryDTO: Codable {
    let id: Int
    let url: URL
    let name: String
    let stars: Int
    let license: String?
    let language: String?

    enum CodingKeys: String, CodingKey {
        case id
        case url = "html_url"
        case name
        case stars = "stargazers_count"
        case license
        case language
    }
}
