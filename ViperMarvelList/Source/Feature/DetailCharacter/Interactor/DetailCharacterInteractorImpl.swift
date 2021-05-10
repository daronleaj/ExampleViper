import Foundation

final class DetailCharacterInteractorImpl: BaseInteractor {
    // MARK: - Properties
    weak var presenter: DetailCharacterInteractorCallback?
    
    let detailCharacterRepository: DetailCharacterRepository
 
    init(detailCharacterRepository: DetailCharacterRepository) {
        self.detailCharacterRepository = detailCharacterRepository
    }
}

extension  DetailCharacterInteractorImpl: DetailCharacterInteractor {
    
    func fetchDetailCharacter(characterId: Int) {
        detailCharacterRepository.getDetailCharacter(characterId: characterId, completion: { model in
            self.presenter?.fetchedDetailCharacteres(detailCharacter: model)
        })
    }
}
