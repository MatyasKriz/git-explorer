import Fetcher

final class ApplicationModule: DependencyModule {
    let fetcher: Fetcher
    let decoder: JSONDecoder

    let dataService: DataService

    init() {
        fetcher = Fetcher(requestPerformer: AlamofireRequestPerformer())
        decoder = JSONDecoder()

        dataService = DataService(fetcher: fetcher, decoder: decoder)
    }
}
