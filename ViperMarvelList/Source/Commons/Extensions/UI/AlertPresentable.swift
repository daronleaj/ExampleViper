import UIKit

struct AlertAction {
    let title: String
    let action: Bool
}

enum AlertStyle {
    case error, success, snackbar
}

protocol AlertPresentable {
    func showAlert(with style: AlertStyle, title: String?, message: String?, imageName: String?, actionTitle: String?, completion: (() -> Void)?)
    func showAlertSnackbar(with title: String?, message: String?, overTabbar: Bool, actionTitle: String?, completion: (() -> Void)?)
}

extension AlertPresentable where Self: BaseViewController {
    func showAlert(with style: AlertStyle, title: String? = nil, message: String? = nil, imageName: String? = nil, actionTitle: String? = nil, completion: (() -> Void)? = nil) {
        switch style {
        case .error:
            showErrorAlert(with: title, message: message, imageName: imageName, actionTitle: actionTitle, completion: completion)
        case .success:
            showSuccessAlert(with: title, message: message, actionTitle: actionTitle, imageName: imageName ?? "icon-ok", completion: completion)
        case .snackbar:
            showAlertSnackbar(with: title, message: message, overTabbar: false, actionTitle: actionTitle, completion: completion)
        }
    }
    
    // this permits to show 1 message by viewcontroller in different tabbar options
    private func showErrorAlert(with title: String?, message: String?, imageName: String?, actionTitle: String?, completion: (() -> Void)?) {
        let presentingViewController =  topMostViewController()
        if CustomAlertManagerImpl.shared.findAlertWithPresenting(viewController: presentingViewController) == nil {
            // it controls that presentingViewController is not presenting errorAlert, and so, not to show it
            let foundAlert = presentingViewController.children.first {$0 is PopupAlert}
            guard foundAlert == nil else { return }
            
            let customAlert = CustomAlertImpl()
            customAlert.presentingViewController = presentingViewController
            let errorAlert = customAlert.createErrorAlert(with: title, message: Language.translate(key: message ?? ""), imageName: imageName, actionTitle: actionTitle) { [weak self] in
                CustomAlertManagerImpl.shared.removeAlertWithPresenting(viewController: presentingViewController)
                self?.disableInteractivePopGestureRecognizerInNavigationController(presentingViewController)
                DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(200)) {
                    completion?()
                }
            }
            disableInteractivePopGestureRecognizerInNavigationController(presentingViewController, isEnabled: false)
            presentingViewController.add(errorAlert)
            CustomAlertManagerImpl.shared.add(alert: customAlert)
        }
    }
       
    private func showSuccessAlert(with title: String?, message: String?, actionTitle: String?, imageName: String, completion: (() -> Void)?) {
        if CustomAlertImpl.shared.alert == nil {
            let successAlert = CustomAlertImpl.shared.createSuccessAlert(with: title, message: message, actionTitle: actionTitle, completionAction: completion, imageName: imageName )
            topMostViewController().add(successAlert)
        }
    }
    
    func showAlertSnackbar(with title: String?, message: String?, overTabbar: Bool, actionTitle: String?, completion: (() -> Void)?) {
        if CustomAlertImpl.shared.alert == nil {
            let snackbar = CustomAlertImpl.shared.createSnackbar(with: title, message: message, actionTitle: actionTitle, completionAction: completion)
            topMostViewController().add(snackbar, isOverTabbar: overTabbar)
        }
    }
    
    private func disableInteractivePopGestureRecognizerInNavigationController(_ presentingViewController: UIViewController, isEnabled: Bool = true) {
        (presentingViewController as? UINavigationController)?.interactivePopGestureRecognizer?.isEnabled = isEnabled
    }
}

extension BaseViewController: AlertPresentable {
}
