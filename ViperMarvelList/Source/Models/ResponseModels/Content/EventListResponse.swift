import Foundation

struct EventListResponse: Codable {
    let available: Int?
    let returned: Int?
    let collectionURI: String?
    let items: [EventSummaryResponse]?
}

struct EventSummaryResponse: Codable {
    let resourceURI: String?
    let name: String?
}

struct EventSummary: Codable {
    let resourceURI: String
    let name: String
    
    static func mapperToEventSummaryResponse(response: EventSummaryResponse) -> EventSummary {
        return EventSummary(resourceURI: response.resourceURI ?? "",
                            name: response.name ?? "")
    }
}

struct EventList: Codable {
    let available: Int
    let collectionURI: String
    let items: [EventSummary]
    
    static func mapperToEventSummaryResponse(response: EventListResponse?) -> EventList? {
        guard let response = response else {
            return nil
        }
        
        var items: [EventSummary] = []
        response.items?.forEach { itemEventSummary in
            items.append( EventSummary.mapperToEventSummaryResponse(response: itemEventSummary) )
        }
        return EventList(available: response.available ?? 0,
                         collectionURI: response.collectionURI ?? "",
                         items: items)
    }
}
