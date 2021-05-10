import UIKit

class SplashScreenConfigurator {

    class func createModule() -> UIViewController {

        let view = SplashScreenViewController()
        let interactor: SplashScreenInteractorImpl = SplashScreenInteractorImpl()
        let router: SplashScreenRouterImpl = SplashScreenRouterImpl(mainRouter: RouterImpl(parentVC: view))
        let presenter: SplashScreenPresenterImpl = SplashScreenPresenterImpl()
        
        view.presenter = presenter
        
        presenter.view = view
        presenter.interactor = interactor
        presenter.router = router
        interactor.presenter = presenter
        
        return view
    }
   
}
