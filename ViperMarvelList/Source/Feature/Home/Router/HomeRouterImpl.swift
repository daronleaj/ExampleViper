import Foundation

final class HomeRouterImpl: BaseRouter {

    var mainRouter: Router
    
    init(mainRouter: Router) {
        self.mainRouter = mainRouter
    }
}

extension HomeRouterImpl: HomeRouter {
    
    func goToDetailCharacter(characterId: Int) {
        mainRouter.navigateToDetailCharacter(characterId: characterId)
    }
}
