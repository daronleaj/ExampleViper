import Foundation

struct StoryListResponse: Codable {
    let available: Int?
    let returned: Int?
    let collectionURI: String?
    let items: [StorySummaryResponse]?
}

struct StorySummaryResponse: Codable {
    let resourceURI: String?
    let name: String?
    let type: String?
}

struct StorySummary: Codable {
    let resourceURI: String
    let name: String
    let type: String
    
    static func mapperToStorySummaryResponse(response: StorySummaryResponse) -> StorySummary {
        return StorySummary(resourceURI: response.resourceURI ?? "",
                            name: response.name ?? "",
                            type: response.type ?? "")
    }
}

struct StoryList: Codable {
    let available: Int
    let collectionURI: String
    let items: [StorySummary]
    
    static func mapperToStoryListResponse(response: StoryListResponse?) -> StoryList? {
        guard let response = response else {
            return nil
        }
        
        var items: [StorySummary] = []
        response.items?.forEach { itemStorySummary in
            items.append( StorySummary.mapperToStorySummaryResponse(response: itemStorySummary) )
        }
        return StoryList(available: response.available ?? 0,
                         collectionURI: response.collectionURI ?? "",
                         items: items)
    }
}
