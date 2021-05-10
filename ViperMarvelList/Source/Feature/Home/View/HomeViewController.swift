import UIKit

final class HomeViewController: BaseViewController {
    
    // MARK: - IBOutlet
    @IBOutlet weak var characterTableView: UITableView!
    
    // MARK: - Properties
	var presenter: HomePresenter?
    var refreshControl = UIRefreshControl()
    
    var characteres: [CharacterHomeViewModel] = []
    
    // MARK: - Life Cycle
	override func viewDidLoad() {
        super.viewDidLoad()
        
        setStyles()
        setupView()
        
        presenter?.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        presenter?.viewWillAppear()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        presenter?.viewDidAppear()
    }
}

// MARK: HomeView
extension HomeViewController: HomeView {
    
    func showCharacteres(characteres: [CharacterHomeViewModel]) {
        self.characteres = characteres
        characterTableView.reloadData()
        
        refreshControl.endRefreshing()
    }
    
    func stopRefreshPull() {
        refreshControl.endRefreshing()
    }
}

// MARK: - UITableViewDataSource
extension HomeViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return characteres.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier = HomeTableCell.identifier
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier,
                                                  for: indexPath) as! HomeTableCell
        cell.configureCell(model: characteres[indexPath.row])
        cell.selectionStyle = .none
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
     
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        //Check is user last position
        if indexPath.row + 1 == characteres.count {
            presenter?.userNeedMoreCharacter()
        }
    }

}

// MARK: - UITableViewDelegate
extension HomeViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        presenter?.userSelectItem(itemModel: characteres[indexPath.row])
    }
}

// MARK: - Private methods
private extension HomeViewController {
    
    func setupView() {
        title = Language.translate(key: "appHomeTitle")
        
        characterTableView.register(UINib(nibName: HomeTableCell.identifier, bundle: nil),
                           forCellReuseIdentifier: HomeTableCell.identifier)
        
        characterTableView.rowHeight = UITableView.automaticDimension
        characterTableView.estimatedRowHeight = 64.0
        
        characterTableView.dataSource = self
        characterTableView.delegate = self
        
        refreshControl.attributedTitle = NSAttributedString(string: Language.translate(key: "appGeneralPullToRefresh"))
        refreshControl.addTarget(self, action: #selector(self.refresh(_:)), for: .valueChanged)
        characterTableView.addSubview(refreshControl)
    }
    
    private func setStyles() {
    }
    
    @objc func refresh(_ sender: AnyObject) {
        presenter?.userRefreshView()
    }

}
