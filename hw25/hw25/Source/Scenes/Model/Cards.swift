//
//  Cards.swift
//  hw25
//
//  Created by Panda on 02.09.2022.
//

import UIKit

struct Cards: Decodable {
    let cards: [Card]
}

struct Card: Decodable {
    let nameCard: String
    let type: String?
    let manaCost: String?
    let rarity: String?
    let setName: String?
    let description: String?
    let imageUrl: String?
    let foreignNames: [ForeignNames]?
    
    enum CodingKeys: String, CodingKey {
        case nameCard = "name"
        case type
        case manaCost
        case rarity
        case setName
        case description = "text"
        case imageUrl
        case foreignNames
    }
}
struct ForeignNames: Decodable {
    let name: String?
    let text: String?
    let type: String?
    let imageUrl: String?
    let language: String?
}
