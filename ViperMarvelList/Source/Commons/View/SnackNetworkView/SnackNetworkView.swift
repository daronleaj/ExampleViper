import UIKit

class SnackNetworkView: UIView, XibInstantiatable {
    
    @IBOutlet weak var lblText: UILabel!
    private static var _current: SnackNetworkView!

    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        instantiate()
        setUp()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        instantiate()
        setUp()
    }
    
    private func setUp() {
        lblText.font = UIFont.mainFont(size: .fourteen, fontType: .book)
    }

    static func showForOffline() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0, execute: {
            _current.lblText.backgroundColor = .black
            _current.lblText.text = Language.translate(key: "appNoConnection")
            UIView.transition(with: _current, duration: 0.5, options: .transitionCrossDissolve, animations: {
                _current.isHidden = false
            }, completion: nil)
        })
    }

    static func hideAndPassOnline() {
        DispatchQueue.main.async {
             _current.lblText.backgroundColor = .tealGreen
            _current.lblText.text = Language.translate(key: "appBackOnline")
        }

        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0, execute: {
            UIView.transition(with: _current, duration: 1.0, options: .transitionCrossDissolve, animations: {
                _current.isHidden = true
            }, completion: nil)
        })
    }
}
