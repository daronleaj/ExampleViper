import Foundation

class SplashScreenPresenterImpl: BasePresenter {
    
    // MARK: - Properties
    weak var view: SplashScreenView?
    var interactor: SplashScreenInteractor?
    var router: SplashScreenRouter?

    private func continueExecution() {
        
        //Set delay for example if need to call repository or other services to instance app.
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) { [weak self] in
            self?.initAppFirstLaunch()
        }
    }
    
    private func initAppFirstLaunch() {
        router?.initAppFirstLaunch()
    }
}

extension SplashScreenPresenterImpl: SplashScreenPresenter {
    func viewDidLoad() {
        continueExecution()
    }
    
    func viewWillAppear() {
        //
    }

}

extension SplashScreenPresenterImpl: SplashScreenInteractorCallback {
}
