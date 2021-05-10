import Foundation

enum CharacterError: Error {
    case errorUnknown
}

final class CharacterRepositoryImp: CharacterRepository {
    let remoteApiClient: SessionAPI

    init(remoteApiClient: SessionAPI) {
        self.remoteApiClient = remoteApiClient
    }

    func getCharacteres(limit: Int, offset: Int, completion: @escaping (Result<CharacterData, CharacterError>) -> Void) {
        let requestModel = CharacterRequest(limit: limit, offset: offset)

        remoteApiClient.sendWithError(request: requestModel) { result in
            switch result {
            case .success(let data):
                completion(.success(CharacterData.mapperToCharacterDataWrapperResponse(response: data)))
            case .failure(let error):
                print("\(error)")
                completion(.failure(.errorUnknown))
            }

        }
    }
}
