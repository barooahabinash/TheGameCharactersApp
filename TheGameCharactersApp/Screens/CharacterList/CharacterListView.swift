//
//  GameCharactersView.swift
//  TheGameCharactersApp
//
//  Created by Abinash Barooah on 11/04/2025.
//

import SwiftUI

struct CharacterListView: View {
    @StateObject private var characterListModel = CharacterListViewModel()

    var body: some View {
        NavigationStack {
            VStack {
                if characterListModel.isLoading {
                    ProgressView("Loading characters...")
                } else {
                    ScrollView {
                        LazyVStack(alignment: .leading, spacing: 16) {
                            ForEach(characterListModel.characters) { character in
                                CharacterRowView(character: character)
                                    .onTapGesture {
                                        characterListModel.selectedCharacter = character
                                    }
                            }
                        }
                        .padding()
                    }
                }
            }
            .navigationTitle("Game Characters")
        }
        .onAppear {
            characterListModel.loadCharacters()
        }
        .sheet(item: $characterListModel.selectedCharacter) { character in
            CharacterDetailView(character: character)
        }

    }
}

struct CharacterRowView: View {
    let character: CharacterListModel

    var body: some View {
        HStack(alignment: .center) {
            if let urlString = character.mugShot?.url,
               let url = URL(string: urlString.replacingOccurrences(of: "//", with: "https://")) {
                AsyncImage(url: url) { image in
                    image.resizable()
                         .aspectRatio(contentMode: .fill)
                } placeholder: {
                    ProgressView()
                }
                .frame(width: 60, height: 60)
                .clipShape(RoundedRectangle(cornerRadius: 8))
            } else {
                Rectangle()
                    .fill(Color.gray.opacity(0.3))
                    .frame(width: 60, height: 60)
                    .clipShape(RoundedRectangle(cornerRadius: 8))
            }
            Text(character.name)
                .font(.headline)
                .padding(.leading, 8)
        }
    }
}

#Preview {
    CharacterListView()
}
