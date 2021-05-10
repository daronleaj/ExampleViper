import Foundation

// MARK: - View
protocol HomeView: BaseView, ErrorView {
    
    var presenter: HomePresenter? { get set }
    
    func showCharacteres(characteres: [CharacterHomeViewModel])
    func stopRefreshPull()
}

// MARK: - Presenter
protocol HomePresenter: class{
    
    var view: HomeView? { get set }
    var interactor: HomeInteractor? { get set }
    var router: HomeRouter? { get set }
    
    func viewDidLoad()
    func viewWillAppear()
    func viewDidAppear()
    
    func userSelectItem(itemModel: CharacterHomeViewModel)
    func userRefreshView()
    func userNeedMoreCharacter()
}

// MARK: - Interactor
protocol HomeInteractorCallback: class {
    func fetchedCharacteres(characteres: Result<CharacterData, CharacterError>)
}

protocol HomeInteractor: class {
    var presenter: HomeInteractorCallback? { get set }
    
    func fetchCharacteres(limit: Int, offset: Int)
}

// MARK: - Router
protocol HomeRouter: class {
    func goToDetailCharacter(characterId: Int)
}
