import Foundation

class DetailCharacterRequest: APIRequest {
    typealias Response = CharacterDataWrapperResponse
    
    let characterId: Int
    
    init(characterId: Int) {
        self.characterId = characterId
    }
    
    var method: Method {
        return .GET
    }
    
    var path: String {
        return "characters/\(characterId)"
    }
    
    var headers: [String: String] {
        return [:]
    }
    
    var parameters: [String: String] {
        return [:]
    }
    
    var bodyObjects: [String: Any] {
        return  [:]
    }
    
}
