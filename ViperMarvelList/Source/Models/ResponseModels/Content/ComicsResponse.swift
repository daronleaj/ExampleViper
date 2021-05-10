import Foundation

struct ComicsResponse: Codable {
    let available: Int?
    let returned: Int?
    let collectionURI: String?
    let items: [ComicSummaryResponse]?
}

struct ComicSummaryResponse: Codable {
    let resourceURI: String?
    let name: String?
}

struct ComicSummary: Codable {
    let name: String
    let resourceURI: String
    
    static func mapperToComicSummaryResponse(response: ComicSummaryResponse) -> ComicSummary {
        return ComicSummary(name: response.name ?? "",
                            resourceURI: response.resourceURI ?? "")
    }
}

struct Comics: Codable {
    let available: Int
    let collectionURI: String
    let items: [ComicSummary]
    
    static func mapperToComicsResponse(response: ComicsResponse?) -> Comics? {
        guard let response = response else {
            return nil
        }
        
        var items: [ComicSummary] = []
        response.items?.forEach { itemComicSummary in
            items.append( ComicSummary.mapperToComicSummaryResponse(response: itemComicSummary) )
        }
        return Comics(available: response.available ?? 0,
                     collectionURI: response.collectionURI ?? "",
                     items: items)
    }
}
