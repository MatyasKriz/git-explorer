import Reactant

final class UserDetailsView: ViewBase<UserAccount, Void> {
    let avatar = UIImageView()
    let login = UILabel()
    let totalStars = UILabel()
    let totalRepositories = UILabel()
    let favoriteLanguage = UILabel()

    override func update() {
        avatar.image = componentState.user.avatar
        login.text = componentState.user.login
        if let repositories = componentState.repositories {
            totalStars.text = "🌟 \(repositories.filter { $0.name != "None" }.reduce(0) { $0 + $1.stars })"
            totalRepositories.text = "📖 \(repositories.count)"
            if let language = repositories.map({ $0.language }).filter({ $0 != "None" }).mostFrequentElement {
                favoriteLanguage.text = "❤️ \(language)"
            } else {
                favoriteLanguage.text = nil
            }
        } else {
            totalStars.text = nil
            totalRepositories.text = nil
            favoriteLanguage.text = nil
        }
    }
}
