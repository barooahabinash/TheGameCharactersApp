//
//  TokenResponseModel.swift
//  TheGameCharactersApp
//
//  Created by Abinash Barooah on 13/04/2025.
//

import Foundation

struct TokenResponse: Codable {
    let access_token: String
    let expires_in: Int
    let token_type: String
}
