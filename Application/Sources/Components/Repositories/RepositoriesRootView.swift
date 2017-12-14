import Reactant
import RxSwift

typealias UserAccount = (user: User, repositories: [Repository]?)

final class RepositoriesRootView: ViewBase<UserAccount, PlainTableViewAction<RepositoryCell>> {
    let repositoryTableView = PlainTableView<RepositoryCell>(reloadable: false)
    let activityIndicator = UIActivityIndicatorView()
    private let userDetails = UserDetailsView()

    override var actions: [Observable<PlainTableViewAction<RepositoryCell>>] {
        return [
            repositoryTableView.action
        ]
    }

    override func update() {
        if let repositories = componentState.repositories {
            activityIndicator.stopAnimating()
            repositoryTableView.componentState = repositories.isEmpty ? .empty(message: "No repositories found.") : .items(repositories)
        } else {
            activityIndicator.startAnimating()
            repositoryTableView.componentState = .loading
        }
        userDetails.componentState = componentState
    }

    override func loadView() {
        activityIndicator.activityIndicatorViewStyle = .gray

        repositoryTableView.headerView = userDetails
        repositoryTableView.footerView = UIView()
        repositoryTableView.rowHeight = RepositoryCell.height
        repositoryTableView.separatorStyle = .singleLine
        repositoryTableView.tableView.contentInset.bottom = 0
    }
}
