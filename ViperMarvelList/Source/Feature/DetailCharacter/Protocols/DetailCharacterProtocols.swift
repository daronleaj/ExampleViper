import Foundation

// MARK: - View
protocol DetailCharacterView: BaseView, ErrorView {
    
    var presenter: DetailCharacterPresenter? { get set }
    
    func showDetailCharacter(detailCharacter: DetailCharacterViewModel)
}

// MARK: - Presenter
protocol DetailCharacterPresenter: class{
    
    var view: DetailCharacterView? { get set }
    var interactor: DetailCharacterInteractor? { get set }
    var router: DetailCharacterRouter? { get set }
    
    func viewDidLoad()
    func viewWillAppear()
    func viewDidAppear()
}

// MARK: - Interactor
protocol DetailCharacterInteractorCallback: class {
    func fetchedDetailCharacteres(detailCharacter: Result<Character, DetailCharacterError>)
}

protocol DetailCharacterInteractor: class {
    var presenter: DetailCharacterInteractorCallback? { get set }
    
    func fetchDetailCharacter(characterId: Int)
}

// MARK: - Router
protocol DetailCharacterRouter: class {
    func goBack()
}
