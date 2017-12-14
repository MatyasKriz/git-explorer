import Reactant

final class MainController: ControllerBase<Void, MainRootView> {
    struct Dependencies {
        let dataService: DataService
    }
    struct Reactions {
        let userSelected: (User) -> Void
    }

    private let dependencies: Dependencies
    private let reactions: Reactions

    init(dependencies: Dependencies, reactions: Reactions) {
        self.dependencies = dependencies
        self.reactions = reactions
        super.init(title: "RExplorer")
    }

    override func afterInit() {
        self.rootView.componentState = nil
        updateUsers()
    }

    override func act(on action: PlainTableViewAction<UserCell>) {
        switch action {
        case .selected(let user):
            reactions.userSelected(user)
        case .refresh:
            self.updateUsers()
        case .rowAction(_, _):
            break
        }
    }

    private func updateUsers() {
        dependencies.dataService.users()
            .subscribe(onNext: { [unowned self] users in
                self.rootView.componentState = users
            })
            .disposed(by: lifetimeDisposeBag)
    }
}
