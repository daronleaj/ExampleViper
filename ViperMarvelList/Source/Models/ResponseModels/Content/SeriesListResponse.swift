import Foundation

struct SeriesListResponse: Codable {
    let available: Int?
    let returned: Int?
    let collectionURI: String?
    let items: [SeriesSummaryResponse]?
}

struct SeriesSummaryResponse: Codable {
    let resourceURI: String?
    let name: String?
}

struct SeriesSummary: Codable {
    let resourceURI: String
    let name: String
    
    static func mapperToSeriesSummaryResponse(response: SeriesSummaryResponse) -> SeriesSummary {
        return SeriesSummary(resourceURI: response.resourceURI ?? "",
                             name: response.name ?? "")
    }
}

struct SeriesList: Codable {
    let available: Int
    let collectionURI: String
    let items: [SeriesSummary]
    
    static func mapperToSeriesListResponse(response: SeriesListResponse?) -> SeriesList? {
        guard let response = response else {
            return nil
        }
        
        var items: [SeriesSummary] = []
        response.items?.forEach { itemSeriesSummary in
            items.append( SeriesSummary.mapperToSeriesSummaryResponse(response: itemSeriesSummary) )
        }
        return SeriesList(available: response.available ?? 0,
                         collectionURI: response.collectionURI ?? "",
                         items: items)
    }
}

