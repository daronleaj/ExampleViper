import UIKit

final class HomeConfigurator {

    class func createModule() -> UIViewController {
        
        let remoteSessionApi = SessionAPI()
        let characterRepository = CharacterRepositoryImp(remoteApiClient: remoteSessionApi)
        
        let view = HomeViewController()
        let interactor: HomeInteractorImpl = HomeInteractorImpl(characterRepository: characterRepository)
        
        let router: HomeRouterImpl = HomeRouterImpl(mainRouter: RouterImpl(parentVC: view))
        let presenter: HomePresenterImpl = HomePresenterImpl()
        
        view.presenter = presenter
        view.offlineChanges = presenter
        presenter.view = view
        presenter.interactor = interactor
        presenter.router = router
        interactor.presenter = presenter
        
        return view
    }
   
}
