import Foundation

final class HomeInteractorImpl: BaseInteractor {
    // MARK: - Properties
    weak var presenter: HomeInteractorCallback?
    
    let characterRepository: CharacterRepository
 
    init(characterRepository: CharacterRepository) {
        self.characterRepository = characterRepository
    }
}

extension  HomeInteractorImpl: HomeInteractor {
    
    func fetchCharacteres(limit: Int, offset: Int) {
        characterRepository.getCharacteres(limit: limit, offset: offset, completion: { model in
            self.presenter?.fetchedCharacteres(characteres: model)
        })
    }
}
