import UIKit
import Reactant

final class MainWireframe: Wireframe {
    private let module: DependencyModule

    init(module: DependencyModule) {
        self.module = module
    }

    func entrypoint() -> UIViewController {
        let mainController = main()
        return UINavigationController(rootViewController: mainController)
    }

    private func main() -> MainController {
        return create { provider in
            let dependencies = MainController.Dependencies(dataService: module.dataService)
            let reactions = MainController.Reactions(
                userSelected: { user in
                    provider.navigation?.push(controller: self.repositories(user: user))
                })

            return MainController(dependencies: dependencies, reactions: reactions)
        }
    }

    private func repositories(user: User) -> RepositoriesController {
        return create { provider in
            let dependencies = RepositoriesController.Dependencies(dataService: module.dataService)
            let properties = RepositoriesController.Properties(user: user)
            let reactions = RepositoriesController.Reactions(
                repositorySelected: { url in
                    if #available(iOS 10.0, *) {
                        UIApplication.shared.open(url)
                    } else {
                        UIApplication.shared.openURL(url)
                    }
                })

            return RepositoriesController(dependencies: dependencies, properties: properties, reactions: reactions)
        }
    }
}
