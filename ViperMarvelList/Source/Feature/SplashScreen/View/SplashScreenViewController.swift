import UIKit

class SplashScreenViewController: BaseViewController {
    
    // MARK: - Properties
    var presenter: SplashScreenPresenter?
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        presenter?.viewWillAppear()
    }
}

extension SplashScreenViewController: SplashScreenView {
}
