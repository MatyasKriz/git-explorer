import Reactant

final class RepositoriesController: ControllerBase<Void, RepositoriesRootView> {
    struct Dependencies {
        let dataService: DataService
    }
    struct Properties {
        let user: User
    }
    struct Reactions {
        let repositorySelected: (URL) -> Void
    }

    private let dependencies: Dependencies
    private let properties: Properties
    private let reactions: Reactions

    init(dependencies: Dependencies, properties: Properties, reactions: Reactions) {
        self.dependencies = dependencies
        self.properties = properties
        self.reactions = reactions
        super.init(title: "Repositories")
    }

    override func afterInit() {
        self.rootView.componentState = (self.properties.user, nil)
        dependencies.dataService.repositories(login: properties.user.login)
            .subscribe(onNext: { [unowned self] repositories in
                self.rootView.componentState = (self.properties.user, repositories.sorted(by: { $0.stars > $1.stars }))
            })
            .disposed(by: lifetimeDisposeBag)
    }

    override func act(on action: PlainTableViewAction<RepositoryCell>) {
        switch action {
        case .selected(let repository):
            reactions.repositorySelected(repository.url)
        case .refresh, .rowAction(_, _):
            break
        }
    }
}
