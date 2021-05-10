import Foundation

class SplashScreenRouterImpl: BaseRouter {

    var mainRouter: Router

    init(mainRouter: Router) {
        self.mainRouter = mainRouter
    }

}

extension SplashScreenRouterImpl: SplashScreenRouter {
    
    func initAppFirstLaunch() {
        mainRouter.createLaunchScreen()
    }
}
