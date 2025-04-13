//
//  CharacterListViewModel.swift
//  TheGameCharactersApp
//
//  Created by Abinash Barooah on 11/04/2025.
//

import Foundation

@MainActor
class CharacterListViewModel: ObservableObject {
    @Published var characters: [CharacterListModel] = []
    @Published var selectedCharacter: CharacterListModel?
    @Published var isLoading = true

    private let service: CharacterServiceProtocol

    init(service: CharacterServiceProtocol = CharacterService()) {
            self.service = service
    }


    func loadCharacters() {
        isLoading = true
        Task {
            do {
                characters = try await service.fetchCharacters()
            } catch {
                print("Error: \(error.localizedDescription)")
            }
            isLoading = false
        }
    }
}
