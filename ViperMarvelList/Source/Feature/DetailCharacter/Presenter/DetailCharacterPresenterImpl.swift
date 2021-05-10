import Foundation

final class DetailCharacterPresenterImpl: BasePresenter {
    // MARK: - Properties
    weak var view: DetailCharacterView?
    var interactor: DetailCharacterInteractor?
    var router: DetailCharacterRouter?
    
    // MARK: - Var
    let characterId: Int
    
    init(characterId: Int) {
        self.characterId = characterId
    }
    
    func isConnected() -> Bool {
        return NetworkManager.isConnected()
    }
}

// MARK: DetailCharacterPresenter
extension DetailCharacterPresenterImpl: DetailCharacterPresenter {
    func viewDidLoad() {
        getDetailCharacter()
    }
    
    func viewWillAppear() {
        //
    }

    func viewDidAppear() {
        //
    }
}

// MARK: - DetailCharacterInteractorCallback
extension DetailCharacterPresenterImpl: DetailCharacterInteractorCallback {

    func fetchedDetailCharacteres(detailCharacter: Result<Character, DetailCharacterError>) {
        view?.hideLoading()
        switch detailCharacter {
        case .success(let detailCharacter):
            view?.showDetailCharacter(detailCharacter: DetailCharacterViewModel.mapperToCharacterHomeViewModel(response: detailCharacter) )
        case .failure(let error):
            switch error {
            case .errorUnknown, .empty:
                view?.showAlertErrorGeneral()
            }
        }
    }
}

// MARK: - OfflineChanges
extension DetailCharacterPresenterImpl: OfflineChanges {
    
    func backToOnline() {
        getDetailCharacter()
    }
    
    func backToOffline() {
        //Nothing to do here
    }
}


// MARK: - Private
private extension DetailCharacterPresenterImpl {
    func getDetailCharacter() {
        if isConnected() {
            view?.showLoading(in: nil)
            interactor?.fetchDetailCharacter(characterId: characterId)
        } else {
            view?.showErrorConnection()
        }
    }
}

