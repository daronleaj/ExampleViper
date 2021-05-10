import UIKit

final class HomeTableCell: UITableViewCell {
    
    static let identifier = "HomeTableCell"
    
    @IBOutlet weak var nameContainerView: UIView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var backgroundImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func configureCell(model: CharacterHomeViewModel) {
        nameContainerView.layer.cornerRadius = 4
        nameLabel.text = model.name
        backgroundImage.sd_setImage(with: URL(string: model.backgroundImage),
                                    placeholderImage: UIImage(named: "ic_emptyBackground"))
    }
    
}
