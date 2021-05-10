import UIKit

class PopupAlert: UIViewController {
    
    @IBOutlet weak var backgroundView: UIView!
    @IBOutlet weak var alertView: UIView!
    @IBOutlet weak var labelTitleAlert: UILabel!
    @IBOutlet weak var labelDescriptionAlert: UILabel!
    @IBOutlet weak var btnAction: UIButton!
    @IBOutlet weak var imageAlert: UIImageView!
    
    let titleAlert: String
    let descriptionAlert: String
    let titleBtn: String
    var imageName: String?
    var customAlertView: CustomAlert?

    init(title: String, description: String, titleBtn: String, imageName: String?) {
        titleAlert = title
        descriptionAlert = description
        self.titleBtn = titleBtn
        self.imageName = imageName
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setStyle()
        setUp()
    }
    
    // MARK: - SetUp
    private func setStyle() {
        backgroundView.backgroundColor = UIColor.greySignIN.withAlphaComponent(0.96)
        labelTitleAlert.font = UIFont.mainFont(size: .eighteen, fontType: .bold)
        labelDescriptionAlert.font = UIFont.mainFont(size: .fourteen, fontType: .book)
        alertView.layer.cornerRadius = 2
    }
    
    private func setUp() {
        view.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.0)
        labelTitleAlert.text = titleAlert
        labelDescriptionAlert.text = descriptionAlert
        btnAction.setTitle(titleBtn, for: .normal)
        if let image = imageName {
            imageAlert.image = UIImage(named: image)
        }
    }
    
    func updateDescription(description: String) {
        labelDescriptionAlert.text = description
    }
    
    // MARK: - Action
    @IBAction func actionButton(_ sender: UIButton) {
        customAlertView?.errorAction()
    }

}
