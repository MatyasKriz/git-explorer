import Reactant
import UIKit

final class RepositoryCell: ViewBase<Repository, Void>, Reactant.TableViewCell {
    static let height: CGFloat = 60

    let name = UILabel()
    let starCount = UILabel()
    let language = UILabel()

    override func update() {
        name.text = componentState.name
        starCount.text = "🌟 \(componentState.stars)"
        language.text = componentState.language != "None" ? "Language: \(componentState.language)" : nil
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

extension RepositoryCell.Styles {
    static func normalBackground(_ cell: RepositoryCell) {
        cell.backgroundColor = nil
    }

    static func highlightedBackground(_ cell: RepositoryCell) {
        cell.backgroundColor = UIColor.lightGray.withAlphaComponent(0.2)
    }
}
