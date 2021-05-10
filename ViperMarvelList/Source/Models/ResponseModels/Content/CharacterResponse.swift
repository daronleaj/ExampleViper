import Foundation

struct CharacterDataWrapperResponse: Codable {
    let code: Int?
    let status: String?
    let copyright: String?
    let attributionText: String?
    let attributionHTML: String?
    let etag: String?
    let data: CharacterDataResponse?
}

struct CharacterDataResponse: Codable {
    let offset: Int?
    let limit: Int?
    let total: Int?
    let count: Int?
    let results: [CharacterResponse]?
}

struct CharacterResponse: Codable {
    let id: Int?
    let name: String?
    let description: String?
    let modified: String?
    let resourceURI: String?
    let urls: [UrlResponse]?
    let thumbnail: ThumbnailResponse?
    let comics: ComicsResponse?
    let stories: StoryListResponse?
    let eventList: EventListResponse?
    let series: SeriesListResponse?
}


struct Character: Codable {
    let id: Int
    let name: String
    let description: String
    let modified: String
    let resourceURI: String
    let urls: [UrlResponse]
    let thumbnail: Thumbnail?
    let comics: Comics?
    let stories: StoryList?
    let eventList: EventList?
    let series: SeriesList?
    
    static func mapperToDomainModel(response: CharacterResponse) -> Character {
        let thumbnail: Thumbnail? = Thumbnail.mapperToThumbnailResponse(response: response.thumbnail)
        let comics: Comics? = Comics.mapperToComicsResponse(response: response.comics)
        let stories: StoryList? = StoryList.mapperToStoryListResponse(response: response.stories)
        let eventList: EventList? = EventList.mapperToEventSummaryResponse(response: response.eventList)
        let series: SeriesList? = SeriesList.mapperToSeriesListResponse(response: response.series)
        
        return Character(id: response.id ?? 0,
                         name: response.name ?? "",
                         description: response.description != "" ? response.description ?? "" : Language.translate(key: "appCharacterEmptyDescription"),
                         modified: response.modified ?? "",
                         resourceURI: response.resourceURI ?? "",
                         urls: [],
                         thumbnail: thumbnail,
                         comics: comics,
                         stories: stories,
                         eventList: eventList,
                         series: series)
    }
}

struct CharacterData: Codable {
    let offset: Int
    let limit: Int
    let total: Int
    let count: Int
    let results: [Character]
    
    static func mapperToCharacterDataWrapperResponse(response: CharacterDataWrapperResponse) -> CharacterData {
        var items: [Character] = []
        response.data?.results?.forEach { itemCharacter in
            items.append( Character.mapperToDomainModel(response: itemCharacter) )
        }
        return CharacterData(offset: response.data?.offset ?? 0,
                             limit: response.data?.limit ?? 0,
                             total: response.data?.total ?? 0,
                             count: response.data?.count ?? 0,
                             results: items)
    }
}
