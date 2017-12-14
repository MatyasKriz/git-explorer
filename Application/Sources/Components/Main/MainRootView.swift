import Reactant
import RxSwift

final class MainRootView: ViewBase<[User]?, PlainTableViewAction<UserCell>> {
    let userTableView = PlainTableView<UserCell>(reloadable: true)

    override var actions: [Observable<PlainTableViewAction<UserCell>>] {
        return [userTableView.action]
    }

    override func update() {
        if let users = componentState {
            userTableView.componentState = users.isEmpty ? .empty(message: "No users found!") : .items(users)
        } else {
            userTableView.componentState = .loading
        }
    }

    override func loadView() {
        userTableView.footerView = UIView()
        userTableView.rowHeight = UserCell.height
        userTableView.separatorStyle = .singleLine
        userTableView.tableView.contentInset.bottom = 0
    }
}
