import UIKit

class RouterImpl: BaseRouter, Router {

    weak var parentVC: UIViewController?

    init(parentVC: UIViewController) {
        self.parentVC = parentVC
    }
    
    // MARK: - First Launch
    func createLaunchScreen() {
        let module = AppModules.createFirstLaunchModule()
        module.changeRootViewController()
    }
    
    // MARK: - Detail Character
    func navigateToDetailCharacter(characterId: Int) {
        let module = AppModules.createDetailCharacterModule(characterId: characterId)
        parentVC?.navigationController?.pushViewController(module, animated: true)
    }
    
    // MARK: - Navigation Helpers
    func navigateBack() {
        parentVC?.navigationController?.popViewController(animated: true)
    }

    func dismissView(animated: Bool) {
        parentVC?.dismiss(animated: animated, completion: nil)
    }
    
    func dismissView(animated: Bool, completion: @escaping () -> Void) {
        parentVC?.dismiss(animated: animated, completion: completion)
    }
    
    func dismissRootViewController() {
        parentVC?.navigationController?.viewControllers.first?.dismiss(animated: true, completion: nil)
    }
    
    func navigateToRootViewController() {
        parentVC?.navigationController?.popToRootViewController(animated: true)
    }
}
