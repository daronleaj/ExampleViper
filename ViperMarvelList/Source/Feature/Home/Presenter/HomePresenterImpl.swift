import Foundation

final class HomePresenterImpl: BasePresenter {
    // MARK: - Properties
    weak var view: HomeView?
    var interactor: HomeInteractor?
    var router: HomeRouter?
    
    // MARK: - Var
    let maxCellFetch: Int = 10
    var offsetCall: Int = 0
    var lastOffsetCall: Int = 0
    var maxCharacter: Int = 1 //Number greater than offset
    var characters: [Character] = []
    
    func isConnected() -> Bool {
        return NetworkManager.isConnected()
    }
}

// MARK: HomePresenter
extension HomePresenterImpl: HomePresenter {
    func viewDidLoad() {
        getNextCharacteres()
    }
    
    func viewWillAppear() {
        //
    }

    func viewDidAppear() {
        //
    }
    
    func userSelectItem(itemModel: CharacterHomeViewModel) {
        router?.goToDetailCharacter(characterId: itemModel.itemCharacter.id)
    }
    
    func userRefreshView() {
        getRefreshCharacteres()
    }
    
    func userNeedMoreCharacter() {
        getNextCharacteres()
    }
}

// MARK: - HomeInteractorCallback
extension HomePresenterImpl: HomeInteractorCallback {
    func fetchedCharacteres(characteres: Result<CharacterData, CharacterError>) {
        view?.hideLoading()
        view?.stopRefreshPull()
        
        switch characteres {
        case .success(let data):
            maxCharacter = data.total
            offsetCall = offsetCall + data.count
            characters.append(contentsOf: data.results)
            view?.showCharacteres(characteres: CharacterHomeViewModel.mapperToCharacterHomeViewModel(response: characters))
        case .failure(let error):
            switch error {
            case .errorUnknown:
                view?.showAlertErrorGeneral()
            }
        }
    }
}

// MARK: - OfflineChanges
extension HomePresenterImpl: OfflineChanges {
    
    func backToOnline() {
        getRefreshCharacteres()
    }
    
    func backToOffline() {
        view?.stopRefreshPull()
    }
}

// MARK: - Private
private extension HomePresenterImpl {
    func getNextCharacteres() {
        lastOffsetCall = offsetCall
        getCharacteres(offset: offsetCall)
    }
    
    func getRefreshCharacteres() {
        getCharacteres(offset: lastOffsetCall)
    }
    
    func getCharacteres(offset: Int) {
        if isConnected() {
            if offset < maxCharacter {
                view?.showLoading(in: nil)
                interactor?.fetchCharacteres(limit: maxCellFetch, offset: offset)
            }
        } else {
            view?.showErrorConnection()
        }
    }
}

