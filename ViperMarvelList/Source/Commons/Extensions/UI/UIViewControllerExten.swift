import UIKit

extension UIViewController {
    func topMostViewController() -> UIViewController {
        return self
    }
    
    func add(_ child: UIViewController, isOverTabbar: Bool = false) {
        addChild(child)
        view.addSubview(child.view)
        
        child.view.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height)
        child.didMove(toParent: self)
        UIAccessibility.post(notification: UIAccessibility.Notification.screenChanged, argument: child.view)
    }
    
    func remove() {
        guard parent != nil else {
            return
        }
        
        willMove(toParent: nil)
        view.removeFromSuperview()
        removeFromParent()
    }
    
    func addFullScreenSubView(view: UIView) {
        let topCons = view.topAnchor.constraint(equalTo: topMostViewController().view.topAnchor, constant: screenHeight)
        topCons.isActive = true
        view.heightAnchor.constraint(equalToConstant: topMostViewController().view.frame.height).isActive = true
        view.widthAnchor.constraint(equalToConstant: screenWidth).isActive = true
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.05) {
            UIView.animate(withDuration: 0.5, animations: {
                topCons.constant = 0
                self.topMostViewController().view.layoutIfNeeded()
            })
        }
    }
    
    func changeRootViewController() {
        UIWindow.key?.rootViewController = self
    }

    func changeRootViewControllerAnimated() {
        UIWindow.key?.switchRootViewController(self)
    }
    
    var presentationStyle: UIModalPresentationStyle {
        return .fullScreen
    }
    
    var isVisible: Bool {
        if isViewLoaded {
            return view.window != nil
        }
        return false
    }
}
