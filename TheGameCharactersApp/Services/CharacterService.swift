//
//  CharacterService.swift
//  TheGameCharactersApp
//
//  Created by Abinash Barooah on 11/04/2025.
//


import Foundation

protocol CharacterServiceProtocol {
    func fetchCharacters() async throws -> [CharacterListModel]
}

class CharacterService: CharacterServiceProtocol {
    private let clientID = "o24cmm96dnitrj9a4dgwv5p6y0g1fv"
    private let clientSecret = "01265ryjashn4sqt44e1w1onh1qhih"

    private var accessToken: String? {
        get { UserDefaults.standard.string(forKey: "game_access_token") }
        set { UserDefaults.standard.set(newValue, forKey: "game_access_token") }
    }

    private var tokenExpiryDate: Date? {
        get {
            if let timestamp = UserDefaults.standard.object(forKey: "game_token_expiry") as? TimeInterval {
                return Date(timeIntervalSince1970: timestamp)
            }
            return nil
        }
        set {
            let timestamp = newValue?.timeIntervalSince1970
            UserDefaults.standard.set(timestamp, forKey: "game_token_expiry")
        }
    }

    func fetchCharacters() async throws -> [CharacterListModel] {
        let token = try await getValidAccessToken()
        return try await makeCharacterRequest(token: token)
    }

    private func getValidAccessToken() async throws -> String {
        if let token = accessToken,
           let expiry = tokenExpiryDate,
           Date() < expiry {
            return token
        }

        let tokenURLString = "https://id.twitch.tv/oauth2/token?client_id=\(clientID)&client_secret=\(clientSecret)&grant_type=client_credentials"

        guard let url = URL(string: tokenURLString) else {
            throw URLError(.badURL)
        }

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")

        let (data, _) = try await URLSession.shared.data(for: request)

        let result = try JSONDecoder().decode(TokenResponse.self, from: data)

        // Save token and expiry date in userdefaults
        accessToken = result.access_token
        tokenExpiryDate = Date().addingTimeInterval(TimeInterval(result.expires_in))
        print(tokenExpiryDate as Any)

        return result.access_token
    }

    private func makeCharacterRequest(token: String) async throws -> [CharacterListModel] {
        guard let url = URL(string: "https://api.igdb.com/v4/characters") else {
            throw URLError(.badURL)
        }

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        request.setValue(clientID, forHTTPHeaderField: "Client-ID")
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        request.httpBody = "fields name, mug_shot.url; limit 50;".data(using: .utf8)

        let (data, _) = try await URLSession.shared.data(for: request)
        return try JSONDecoder().decode([CharacterListModel].self, from: data)
    }
}
