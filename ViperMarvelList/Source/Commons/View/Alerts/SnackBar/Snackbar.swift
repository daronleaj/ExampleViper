import UIKit

class Snackbar: UIViewController {

    // MARK: - IBOutlets
    @IBOutlet weak var labelTitle: UILabel!
    @IBOutlet weak var labelDescription: UILabel!
    @IBOutlet weak var buttonSnackbar: UIButton!
    @IBOutlet weak var containerView: UIView!
    
    // MARK: - Properties
    let titleAlert: String?
    let descriptionAlert: String?
    let titleBtn: String?
    var customAlertView: CustomAlert?
    
    // MARK: - Init
    init(title: String?, description: String?, titleBtn: String?) {
        titleAlert = title
        descriptionAlert = description
        self.titleBtn = titleBtn
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - View Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setStyles()
        setGestures()
        setData()
    }
    
    // MARK: - Styles
    private func setStyles() {
        labelTitle.font = UIFont.mainFont(size: .fourteen, fontType: .medium)
        labelDescription.font = UIFont.mainFont(size: .twelve, fontType: .book)
        buttonSnackbar.titleLabel?.font = UIFont.mainFont(size: .twelve, fontType: .medium)
    }
    
    // MARK: - Gestures
    private func setGestures() {
        buttonSnackbar.addTarget(self, action: #selector(buttonSnackbarAction), for: .touchUpInside)
        let tapView = UITapGestureRecognizer(target: self, action: #selector(tapInContainerView))
        containerView.isUserInteractionEnabled = true
        containerView.addGestureRecognizer(tapView)
    }
    
    // MARK: - Data
    private func setData() {
        labelTitle.text = titleAlert
        labelDescription.text = descriptionAlert
        buttonSnackbar.setTitle(titleBtn, for: .normal)
    }
    
    // MARK: - IBActions
    @objc private func buttonSnackbarAction() {
        customAlertView?.errorAction()
    }
    
    @objc private func tapInContainerView() {
        customAlertView?.closeAction()
    }
}
