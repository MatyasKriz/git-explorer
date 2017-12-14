import Fetcher

final class ApplicationModule: DependencyModule {
    let fetcher: Fetcher
    let dataService: DataService

    init() {
        fetcher = Fetcher(requestPerformer: AlamofireRequestPerformer())
        dataService = DataService(fetcher: fetcher)
    }
}
