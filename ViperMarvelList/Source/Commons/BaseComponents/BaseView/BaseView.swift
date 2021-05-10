import UIKit

protocol BaseView: class {
    func showLoading(in view: UIView?)
    func hideLoading()
}

extension BaseView {
    
    func showLoading(in view: UIView? = nil) {
        LoadingView.showLoading(view)
    }
    
    func hideLoading() {
        LoadingView.hideLoading()
    }
}
