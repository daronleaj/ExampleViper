import UIKit

protocol CustomAlert {
    func errorAction()
    func closeAction()
    func leftAction()
    func rightAction()
    func topAction()
    func middleAction()
    func bottomAction()
}

protocol CustomAlertManager {
    func add(alert: CustomAlert)
    func removeAlertWithPresenting(viewController: UIViewController)
    func findAlertWithPresenting(viewController: UIViewController) -> CustomAlert?

}

class CustomAlertManagerImpl: CustomAlertManager {
    static let shared = CustomAlertManagerImpl()
    
    var alerts = [CustomAlert]()
    
    func add(alert: CustomAlert) {
        alerts.append(alert)
    }
    func removeAlertWithPresenting(viewController: UIViewController) {
        alerts.removeAll { customAlert -> Bool in
            if let customAlert = customAlert as? CustomAlertImpl {
                if customAlert.presentingViewController == viewController {
                    return true
                }
            }
            return false
        }
    }
   
    func findAlertWithPresenting(viewController: UIViewController) -> CustomAlert? {
        
        for customAlert in alerts {
            if let customAlert = customAlert as? CustomAlertImpl {
                if customAlert.presentingViewController == viewController {
                    return customAlert
                }
            }
        }
        return nil
    }
}
class CustomAlertImpl {
    
    static let shared = CustomAlertImpl()
    let titleBtn = Language.translate(key: "appGeneralAccept").uppercased()
    
    var errorCompletion: (() -> Void)?
    var closeCompletion: (() -> Void)?
    var leftCompletionAction: (() -> Void)?
    var rightCompletionAction: (() -> Void)?
    var topCompletionAction: (() -> Void)?
    var middleCompletionAction: (() -> Void)?
    var bottomCompletionAction: (() -> Void)?
    
    var alert: UIViewController?
    weak var presentingViewController: UIViewController?
    
    func createErrorAlert(with title: String?, message: String?, imageName: String?, actionTitle: String?, completionAction: (() -> Void)?) -> PopupAlert {
        let errorAlert = PopupAlert(title: title ?? "", description: message ?? "", titleBtn: actionTitle ?? titleBtn, imageName: imageName)
        errorAlert.customAlertView = self
        errorCompletion = completionAction
        alert = errorAlert
        return errorAlert
    }
    
    func createSuccessAlert(with title: String?, message: String?, actionTitle: String?, completionAction: (() -> Void)?, imageName: String) -> PopupAlert {
        let successAlert = PopupAlert(title: title ?? "", description: message ?? "", titleBtn: actionTitle ?? titleBtn, imageName: imageName)
        successAlert.customAlertView = self
        errorCompletion = completionAction
        alert = successAlert
        return successAlert
    }
    
    func createSnackbar(with title: String?, message: String?, actionTitle: String?, completionAction: (() -> Void)?) -> Snackbar {
        let snackbar = Snackbar(title: title, description: message, titleBtn: actionTitle)
        snackbar.customAlertView = self
        errorCompletion = completionAction
        alert = snackbar
        return snackbar
    }
    
    func remove() {
        guard let alert = alert else { return }
        alert.remove()
        self.alert = nil
    }

}

extension CustomAlertImpl: CustomAlert {
    
    func closeAction() {
        remove()
        if let completion = closeCompletion {
            completion()
        }
    }
    
    func errorAction() {
        remove()
        if let completion = errorCompletion {
            completion()
        }
    }
    
    func leftAction() {
        remove()
        if let completion = leftCompletionAction {
            completion()
        }
    }
    
    func rightAction() {
        remove()
        if let completion = rightCompletionAction {
            completion()
        }
    }

    func topAction() {
        remove()
        if let completion = topCompletionAction {
            completion()
        }
    }

    func middleAction() {
        remove()
        if let completion = middleCompletionAction {
            completion()
        }
    }

    func bottomAction() {
        remove()
        if let completion = bottomCompletionAction {
            completion()
        }
    }
}
