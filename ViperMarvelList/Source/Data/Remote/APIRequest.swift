import Foundation

struct APIConstants {
    static let apiURL = "https://gateway.marvel.com/v1/public/"
    static let marvelPrivateKey = "9df8218eed23c64cf1cbd8b3d5a933a7ec7ab78c"
    static let marvelPublicKey = "17c07b862c495de6f428b36a775ea5e5"
}

enum Method: String {
    case GET
    case POST
    case PUT
    case UPDATE
    case DELETE
}

protocol APIRequest: Encodable {
    associatedtype Response: Codable
    var method: Method { get }
    var baseURL: URL { get }
    var path: String { get }
    var parameters: [String: String] { get }
    var bodyObjects: [String: Any] { get }
    var headers: [String: String] { get }
}

// Default implementation of APIRequest protocol
extension APIRequest {
    
    var baseURL: URL {
        guard let baseURL = URL(string: APIConstants.apiURL) else {
            fatalError("Imposible get baseURL for API")
        }
        return baseURL
    }
    
    func requestWithBaseURL() -> URLRequest {
        
        let URL = baseURL.appendingPathComponent(path)
        
        guard var components = URLComponents(url: URL, resolvingAgainstBaseURL: false) else {
    
            fatalError("Unable to create URLCompounent form \(URL)")
        }
        
        var params = getPrivateAndPublicKey()
        if !parameters.isEmpty {
            params = params.merge(dict: parameters)
        }
        components.queryItems = params.map {
            URLQueryItem(name: $0, value: $1 )
        }
        
        guard let finalURL = components.url else {
            fatalError("Unable to retrieve final URL")
        }
        
        var request = URLRequest(url: finalURL)
        request.httpMethod = method.rawValue
        if !bodyObjects.isEmpty {
            let jsonData = try? JSONSerialization.data(withJSONObject: bodyObjects)
            request.httpBody = jsonData
        }

        // Set Content-Type
        request.addValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type")
        
        return request
    }

    func getPrivateAndPublicKey() -> [String: String] {
        let ts = Date().timeIntervalSince1970.description
        let hash = "\(ts)\(APIConstants.marvelPrivateKey)\(APIConstants.marvelPublicKey)".md5() 
        let params: [String: String] = ["apikey": APIConstants.marvelPublicKey,
                                        "hash": hash,
                                        "ts":ts]

        return params
    }
    
    func generateUrlParams(params: [String], to key: String) -> String? {
        if !params.isEmpty {
            return "\(params.reduce("", { $0.isEmpty ? "&\(key)=\($1)" : "\($0)&\(key)=\($1)"}))"
        }
        return nil
    }
}
