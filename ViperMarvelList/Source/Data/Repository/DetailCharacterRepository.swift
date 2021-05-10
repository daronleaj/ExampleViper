import Foundation

protocol DetailCharacterRepository: class {

    func getDetailCharacter(characterId: Int, completion: @escaping (Result<Character, DetailCharacterError>) -> Void)

}
