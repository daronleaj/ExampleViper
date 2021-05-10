import UIKit

extension ErrorView where Self: BaseViewController {
    func showAlertErrorGeneral() {
        showAlert(with: .error, message: "errInternalServerError")
    }
    
    func showErrorConnection() {
        showAlert(with: .error, title: Language.translate(key:"errAlertTitle"), message: "errConnection")
    }
}

extension BaseViewController: ErrorView {}
