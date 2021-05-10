import UIKit

protocol XibInstantiatable {
    func instantiate()
}

extension XibInstantiatable where Self: UIView {
    func instantiate() {
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: String(describing: type(of: self)), bundle: bundle)
        guard let view = nib.instantiate(withOwner: self, options: nil).first as? UIView else {
            return
        }
        view.frame = bounds
        insertSubview(view, at: 0)
        
        view.autoresizingMask = [UIView.AutoresizingMask.flexibleWidth, UIView.AutoresizingMask.flexibleHeight]
    }
}
