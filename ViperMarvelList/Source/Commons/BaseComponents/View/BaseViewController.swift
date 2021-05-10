import UIKit

protocol OfflineChanges {
    func backToOnline()
    func backToOffline()
}

protocol CanRotate {}

class BaseViewController: UIViewController {
    
    let limitOffset: CGFloat  = 0.70
    var offset: CGFloat = 0.0
    var offlineChanges: OfflineChanges?

    // MARK: - Init and Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
    }   

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        // Suscribe in each controller for network status changes
        subscribeNetworkStatusNotifications()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }

    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
    }
    
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        // log.debug("-+-+-VIEW --> Deinit: \(self) ")
    }

    // MARK: - Network status helpers
    func subscribeNetworkStatusNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(networkIsReachableChange), name: .networkIsReachableChange, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(networkIsNotReachableChange), name: .networkIsNotReachableChange, object: nil)
    }

    @objc func networkIsReachableChange(notification: Notification) {
        SnackNetworkView.hideAndPassOnline()
        offlineChanges?.backToOnline()
    }

    @objc func networkIsNotReachableChange(notification: Notification) {
        SnackNetworkView.showForOffline()
        offlineChanges?.backToOffline()
    }

}
