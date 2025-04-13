//
//  CharacterListModel.swift
//  TheGameCharactersApp
//
//  Created by Abinash Barooah on 11/04/2025.
//

import Foundation

struct CharacterListModel: Identifiable, Codable {
    
    let id: Int
    let name: String
    let mugShot: ImageInfo?

    enum CodingKeys: String, CodingKey {
        case id, name
        case mugShot = "mug_shot"
    }
}

struct ImageInfo: Codable {
    let url: String
}
