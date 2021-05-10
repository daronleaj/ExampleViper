import Foundation
import UIKit

class AppModules {
    
    class func createMainModule() -> UIViewController {
        return createSplashModule()
    }

    // MARK: - Splash
    class func createSplashModule() -> UIViewController {
        return SplashScreenConfigurator.createModule()
    }
    
    // MARK: - First Launch
    class func createFirstLaunchModule() -> UIViewController {
        return UINavigationController(rootViewController: HomeConfigurator.createModule())
    }

    // MARK: - Detail Character
    class func createDetailCharacterModule(characterId: Int) -> UIViewController {
        return DetailCharacterConfigurator.createModule(characterId: characterId)
    }
}
