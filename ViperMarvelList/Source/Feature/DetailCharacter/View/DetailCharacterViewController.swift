import UIKit

final class DetailCharacterViewController: BaseViewController {
    
    // MARK: - IBOutlet
    @IBOutlet weak var characterImage: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    // MARK: - Properties
	var presenter: DetailCharacterPresenter?
    
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

// MARK: DetailCharacterView
extension DetailCharacterViewController: DetailCharacterView {
    
    func showDetailCharacter(detailCharacter: DetailCharacterViewModel) {
        nameLabel.text = detailCharacter.name
        descriptionLabel.text = detailCharacter.description
        characterImage.sd_setImage(with: URL(string: detailCharacter.backgroundImage),
                                    placeholderImage: UIImage(named: "ic_emptyBackground"))
    }
}

// MARK: - Private methods
private extension DetailCharacterViewController {
    
    func setupView() {

    }
    
    private func setStyles() {
    }

}
