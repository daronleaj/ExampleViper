import UIKit

final class DetailCharacterConfigurator {

    class func createModule(characterId: Int) -> UIViewController {
        
        let remoteSessionApi = SessionAPI()
        let detailCharacterRepository = DetailCharacterRepositoryImp(remoteApiClient: remoteSessionApi)
        
        let view = DetailCharacterViewController()
        let interactor: DetailCharacterInteractorImpl = DetailCharacterInteractorImpl(detailCharacterRepository: detailCharacterRepository)
        
        let router: DetailCharacterRouterImpl = DetailCharacterRouterImpl(mainRouter: RouterImpl(parentVC: view))
        let presenter: DetailCharacterPresenterImpl = DetailCharacterPresenterImpl(characterId: characterId)
        
        view.offlineChanges = presenter
        view.presenter = presenter
        presenter.view = view
        presenter.interactor = interactor
        presenter.router = router
        
        interactor.presenter = presenter
        
        return view
    }
   
}
