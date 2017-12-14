import Foundation

struct UserDTO: Codable {
    let id: Int
    let avatarUrl: URL
    let login: String
    let repositoriesUrl: String
    let accountUrl: URL

    enum CodingKeys: String, CodingKey {
        case id
        case avatarUrl = "avatar_url"
        case login
        case repositoriesUrl = "repos_url"
        case accountUrl = "url"
    }
}
