import Foundation

enum DetailCharacterError: Error {
    case errorUnknown
    case empty
}

final class DetailCharacterRepositoryImp: DetailCharacterRepository {
    let remoteApiClient: SessionAPI

    init(remoteApiClient: SessionAPI) {
        self.remoteApiClient = remoteApiClient
    }

    func getDetailCharacter(characterId: Int, completion: @escaping (Result<Character, DetailCharacterError>) -> Void) {
        let requestModel = DetailCharacterRequest(characterId: characterId)

        remoteApiClient.sendWithError(request: requestModel) { result in
            switch result {
            case .success(let data):
                if let character = data.data?.results?.first {
                    completion(.success(Character.mapperToDomainModel(response: character)))
                } else {
                    completion(.failure(.empty))
                }
                
            case .failure(let error):
                print("\(error)")
                completion(.failure(.errorUnknown))
            }

        }
    }
}
