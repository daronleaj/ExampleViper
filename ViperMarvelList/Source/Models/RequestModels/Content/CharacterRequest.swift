import Foundation

class CharacterRequest: APIRequest {
    typealias Response = CharacterDataWrapperResponse
    
    let limit: Int
    let offset: Int
    
    init(limit: Int,
         offset: Int) {
        self.limit = limit
        self.offset = offset
    }
    
    var method: Method {
        return .GET
    }
    
    var path: String {
        return "characters"
    }
    
    var headers: [String: String] {
        return [:]
    }
    
    var parameters: [String: String] {
        var params:[String: String] = [:]
        params["limit"] = "\(limit)"
        params["offset"] = "\(offset)"
        return params
    }
    
    var bodyObjects: [String: Any] {
        return  [:]
    }
    
}
