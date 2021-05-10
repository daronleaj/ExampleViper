import UIKit

extension UIWindow {
    
    static var key: UIWindow? {
        guard let kWindow = UIApplication.shared.connectedScenes
                .filter({$0.activationState == .foregroundActive})
                .map({$0 as? UIWindowScene})
                .compactMap({$0})
                .first?.windows
                .filter({$0.isKeyWindow}).first else { return nil }
        
        return kWindow
    }
    
    func switchRootViewController(_ viewController: UIViewController, animated: Bool = true, duration: TimeInterval = 1.0, options: UIView.AnimationOptions = .transitionCrossDissolve, completion: (() -> Void)? = nil) {
        guard animated else {
            rootViewController = viewController
            return
        }

        UIView.transition(with: self, duration: duration, options: options, animations: {
            let oldState = UIView.areAnimationsEnabled
            UIView.setAnimationsEnabled(false)
            self.rootViewController = viewController
            UIView.setAnimationsEnabled(oldState)
        }, completion: { _ in
            completion?()
        })
    }
}
