import Foundation
import Alamofire

final class SessionAPI {
    
    lazy var session: URLSession = {
        let config = URLSessionConfiguration.default
        config.timeoutIntervalForResource = 300
        let session = URLSession(configuration: config)
        
        return session
    }()
    
    func send<T: APIRequest>(request: T, completion: @escaping((T.Response) -> Void)) {
        
        let req = request.requestWithBaseURL()
        
        AF.request(req).validate().responseData { data in
            if let data = data.data {
                do {
                    let model = try JSONDecoder().decode(T.Response.self, from: data)
                    completion(model)
                } catch let error {
                    print("\(error)")
                }
            }
        }
    }

    func sendWithError<T: APIRequest>(request: T, isAuthentication: Bool = false, completion: @escaping((Result<T.Response, APIError>) -> Void)) {

        let req = request.requestWithBaseURL()

        AF.request(req).validate().responseData { data in
            if let data = data.data {
                var bytesData = data
                if bytesData.isEmpty {
                    // We force a local body content
                    bytesData = Data("{\"result\":true}".utf8)
                }
                do {
                    let model = try JSONDecoder().decode(T.Response.self, from: bytesData)
                    completion(.success(model))
                } catch let error {
                    print("\(error)")
                }
            }
        }
    }
    
    func sendWithDataError<T: APIRequest>(request: T, completion: @escaping((Result<Data, APIError>) -> Void)) {
        
        let req = request.requestWithBaseURL()
        
        AF.request(req).validate().responseData { response in
            switch response.result {
            case .success(let  data):
                completion(.success(data))
            case .failure:
                completion(.failure(.errorUnknown))
            }
        }
    }
    
    func getJSONWithError<T: APIRequest>(request: T, jsonName: String, completion: @escaping((Result<T.Response, APIError>) -> Void)) {

        
        if let path = Bundle.main.path(forResource: jsonName, ofType: "json") {
            do {
                  let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                  do {
                      let model = try JSONDecoder().decode(T.Response.self, from: data)
                      completion(.success(model))
                  } catch let error {
                    print("\(error)")
                  }
              } catch {
                completion(.failure(.errorUnknown))
              }
        }
    }
}
