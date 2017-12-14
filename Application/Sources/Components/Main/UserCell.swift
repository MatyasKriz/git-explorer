import Reactant
import UIKit

final class UserCell: ViewBase<User, Void>, Reactant.TableViewCell {
    static let height: CGFloat = 80

    let avatar = UIImageView()
    let login = UILabel()

    override func update() {
        login.text = componentState.login
        avatar.image = componentState.avatar
    }

    func setHighlighted(_ highlighted: Bool, animated: Bool) {
        let style = { self.apply(style: highlighted ? Styles.highlightedBackground : Styles.normalBackground) }
        if animated {
            UIView.animate(withDuration: 0.7, animations: style)
        } else {
            style()
        }
    }
}

extension UserCell.Styles {
    static func normalBackground(_ cell: UserCell) {
        cell.backgroundColor = nil
    }

    static func highlightedBackground(_ cell: UserCell) {
        cell.backgroundColor = UIColor.lightGray.withAlphaComponent(0.2)
    }
}
