import Foundation

final class DetailCharacterRouterImpl: BaseRouter {

    var mainRouter: Router
    
    init(mainRouter: Router) {
        self.mainRouter = mainRouter
    }
}

extension DetailCharacterRouterImpl: DetailCharacterRouter {
    
    func goBack() {
//        mainRouter.goBack()
    }
}
