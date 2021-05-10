import Foundation

// MARK: - View
protocol SplashScreenView: BaseView {
    
    var presenter: SplashScreenPresenter? { get set }
}

// MARK: - Presenter
protocol SplashScreenPresenter: class {
    
    var view: SplashScreenView? { get set }
    var interactor: SplashScreenInteractor? { get set }
    var router: SplashScreenRouter? { get set }
    
    func viewWillAppear()
    func viewDidLoad()
}

// MARK: - Interactor
protocol SplashScreenInteractorCallback: class {
}

protocol SplashScreenInteractor: class {

    var presenter: SplashScreenInteractorCallback? { get set }
}

// MARK: - Router
protocol SplashScreenRouter: class {
    func initAppFirstLaunch()
}
