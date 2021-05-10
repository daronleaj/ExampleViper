import Foundation

struct DetailCharacterViewModel {
    let backgroundImage: String
    let name: String
    let description: String
    let itemCharacter: Character
    
    static func mapperToCharacterHomeViewModel(response: Character) -> DetailCharacterViewModel {
        return DetailCharacterViewModel(backgroundImage: response.thumbnail?.urlImg ?? "",
                                        name: response.name,
                                        description: response.description,
                                        itemCharacter: response)
    }
}
