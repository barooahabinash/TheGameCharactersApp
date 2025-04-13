//
//  CharacterDetailView.swift
//  TheGameCharactersApp
//
//  Created by Abinash Barooah on 13/04/2025.
//

import SwiftUI

struct CharacterDetailView: View {
    let character: CharacterListModel
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        VStack(spacing: 16) {
            HStack {
                Spacer()
                Button(action: {
                    dismiss()
                }) {
                    Image(systemName: "xmark.circle.fill")
                        .font(.title2)
                        .foregroundColor(.gray)
                }
            }
            .padding(.trailing)

            if let urlString = character.mugShot?.url,
               let url = URL(string: urlString.replacingOccurrences(of: "//", with: "https://")) {
                AsyncImage(url: url) { image in
                    image.resizable()
                         .aspectRatio(contentMode: .fit)
                         .cornerRadius(12)
                         .shadow(radius: 10)
                } placeholder: {
                    ProgressView()
                }
                .frame(maxHeight: .infinity)
            }
            else {
                VStack {
                    Image(systemName: "person.crop.square")
                        .resizable()
                        .scaledToFit()
                        .frame(height: 200)
                        .foregroundColor(.gray.opacity(0.5))
                    Text("No Image Available")
                        .font(.subheadline)
                        .foregroundColor(.gray)
                }
                .frame(maxHeight: .infinity)
            }

            Text(character.name)
                .font(.largeTitle)
                .bold()
                .padding()

            Spacer()
        }
        .padding()
    }
}

#Preview {
    //Adding mock data only for preview
    let mockdata = CharacterListModel(
        id: 3305, name: "Jolyne Cujoh", mugShot: ImageInfo(url:"//images.igdb.com/igdb/image/upload/t_thumb/cm33e.jpg")
    )
    CharacterDetailView(character: mockdata)
}
