//
//  ContentView.swift
//  Fetch Recipe App
//
//  Created by Pedro Romero on 1/3/25.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel = recipeView()
    
    
    var body: some View {
        NavigationView{
            VStack {
                if let errorMessage = viewModel.errorMessage {
                    Text(errorMessage)
                        .foregroundStyle(.red)
                        .padding()
                }else{
                    List(viewModel.recipes) { recipe in
                        HStack {
                            AsyncImage(url: URL (string: recipe.photoURLSmall ?? "")) { image in
                                image
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: 75, height: 75)
                                    .clipShape(.circle)
                            } placeholder: {
                                Color.gray
                                    .frame(width: 75, height: 75)
                                    .clipShape(.circle)
                            }
                            
                            VStack (alignment: .leading) {
                                Text (recipe.name)
                                    .font(.headline)
                                Text (recipe.cuisine)
                                    .font(.subheadline)
                                    .foregroundStyle(.secondary)
                            }
                        }
                    }
                    .navigationTitle("Cuisines! 👨‍🍳")
                    .task {
                        await viewModel.getReceipes()
                    }
                }
            }
        }
    }
}


#Preview {
    ContentView()
}
