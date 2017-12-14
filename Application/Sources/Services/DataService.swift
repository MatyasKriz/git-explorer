import Fetcher
import class RxSwift.Observable
import Result
import UIKit

private struct Endpoints: EndpointProvider {
    static func users(position: Int, perPage: Int) -> GET<Void, Data> {
        return create("users?since=\(position)&per_page=\(perPage)", modifiers: Constants.apiUrl)
    }

    static func repositories(userLogin: String) -> GET<Void, Data> {
        return create("users/\(userLogin)/repos", modifiers: Constants.apiUrl)
    }

    static func avatar(url: URL) -> GET<Void, Data> {
        return create(url.absoluteString)
    }
}

final class DataService {

    private let fetcher: Fetcher

    init() {
        fetcher = Fetcher(requestPerformer: AlamofireRequestPerformer())
        fetcher.register(requestEnhancers: RequestLogger(defaultOptions: .all))
    }

    func users(perPage: Int = Constants.usersPerPage) -> Observable<[User]> {
        let randomPosition = Int(arc4random_uniform(Constants.randomNumberLimit))
        return fetcher.rx.request(Endpoints.users(position: randomPosition, perPage: perPage))
            .map { response -> [UserDTO] in
                guard let data = response.rawData else { return [] }
                return (try? JSONDecoder().decode([UserDTO].self, from: data)) ?? []
            }
            .flatMapLatest { [unowned self] userDTOs -> Observable<[User]> in
                return Observable.from(
                    userDTOs.map { userDTO in
                        return self.avatar(url: userDTO.avatarUrl).map { User(avatar: $0, login: userDTO.login, accountUrl: userDTO.accountUrl) }
                    }).merge().toArray()
            }
    }

    func repositories(login: String) -> Observable<[Repository]> {
        return fetcher.rx.request(Endpoints.repositories(userLogin: login))
            .map { response in
                guard let data = response.rawData else { return [] }
                return ((try? JSONDecoder().decode([RepositoryDTO].self, from: data)) ?? [])
                    .map { repositoryDTO in
                        return Repository(name: repositoryDTO.name, stars: repositoryDTO.stars, language: repositoryDTO.language ?? "None", url: repositoryDTO.url)
                    }
            }
    }

    private func avatar(url: URL) -> Observable<UIImage?> {
        return fetcher.rx.request(Endpoints.avatar(url: url))
            .map { response in
                guard let data = response.rawData else { return nil }
                return UIImage(data: data)
            }
    }
}
