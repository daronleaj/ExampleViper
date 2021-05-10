import Foundation

protocol CharacterRepository: class {

    func getCharacteres(limit: Int, offset: Int, completion: @escaping (Result<CharacterData, CharacterError>) -> Void)

}
