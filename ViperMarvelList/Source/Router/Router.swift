import Foundation
import UIKit

protocol Router {
    
    // MARK: - Launch Screen
    func createLaunchScreen()
    
    // MARK: - Detail Character
    func navigateToDetailCharacter(characterId: Int)
    
    // MARK: - Navigation Helpers
    func navigateBack()
    func dismissView(animated: Bool)
    func dismissView(animated: Bool, completion: @escaping () -> Void)
    func dismissRootViewController()
    func navigateToRootViewController()
}
