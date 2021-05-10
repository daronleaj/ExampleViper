import Foundation

struct ThumbnailResponse: Codable {
    let path: String?
    let `extension`: String?
}

struct Thumbnail: Codable {
    let urlImg: String
    
    static func mapperToThumbnailResponse(response: ThumbnailResponse?) -> Thumbnail? {
        guard let response = response else {
            return nil
        }
        let path = response.path ?? ""
        let imageExtension = response.extension ?? ""
        return Thumbnail(urlImg: path + "." + imageExtension)
    }
}
