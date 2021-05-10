import Foundation

struct CharacterHomeViewModel {
    let backgroundImage: String
    let name: String
    let itemCharacter: Character
    
    static func mapperToCharacterHomeViewModel(response: [Character]) -> [CharacterHomeViewModel] {
        var items: [CharacterHomeViewModel] = []
        response.forEach { itemCharacter in
            items.append(CharacterHomeViewModel(backgroundImage: itemCharacter.thumbnail?.urlImg ?? "",
                                                name: itemCharacter.name,
                                                itemCharacter: itemCharacter))
        }
        return items
    }
}
