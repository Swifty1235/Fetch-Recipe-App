//
//  DetailedView.swift
//  Fetch Recipe App
//
//  Created by Pedro Romero on 1/3/25.
//

import SwiftUI

struct DetailedView: View {
    let recipe: Recipe
    
    var body: some View {
        ScrollView {
            VStack {
                AsyncImage(url: URL(string: recipe.photoURLLarge ?? "")) {
                    image in image
                        .resizable()
                        .scaledToFit()
                        .frame(maxWidth: .infinity)
                } placeholder: {
                    Color.gray
                        .frame(maxWidth: 200)
                }
                Text(recipe.name)
                    .font(.headline)
                    .fontWeight(.bold)
                
                Text("Cusine Type: \(recipe.cuisine)")
                    .foregroundStyle(.red)
                    .italic(true)
                    
                if let sourceURL = recipe.sourceURL {
                    Link("View Recipe", destination: URL (string: sourceURL)!)
                        .font(.headline)
                        .foregroundStyle(.red)
                }
                
                if let youtubeURL = recipe.youtubeURL {
                    Link("Watch Video", destination: URL (string: youtubeURL)!)
                        .font(.headline)
                }
            }
            .padding()
        }
        .navigationTitle(recipe.name)
    }
}

#Preview {
    ContentView()
}
