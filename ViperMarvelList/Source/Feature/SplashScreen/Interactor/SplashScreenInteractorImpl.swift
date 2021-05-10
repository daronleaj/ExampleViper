import Foundation

class SplashScreenInteractorImpl: BaseInteractor {
    // MARK: - Properties
    weak var presenter: SplashScreenInteractorCallback?
}

extension SplashScreenInteractorImpl: SplashScreenInteractor {
}
