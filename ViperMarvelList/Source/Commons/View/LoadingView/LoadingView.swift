import UIKit

class LoadingView: UIView, XibInstantiatable {
    
    @IBOutlet weak var backgroundView: UIView!
    @IBOutlet weak var loadingContentView: UIView!
    private static var _current: LoadingView!

    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        instantiate()
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        instantiate()
    }
    
    static func showLoading(_ container: UIView? = nil) {
        DispatchQueue.main.async {
            _current?.removeFromSuperview()
            UIWindow.key?.endEditing(true)
            if let container = container {
                _current = LoadingView(frame: container.bounds)
                container.addSubview(_current)
            } else {
                _current = LoadingView(frame: UIScreen.main.bounds)
                UIWindow.key?.addSubview(_current)
            }
        }
    }
    
    static func hideLoading() {
        DispatchQueue.main.async {
            _current?.removeFromSuperview()
            _current = nil
        }
    }
}
