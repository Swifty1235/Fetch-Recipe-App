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
                }else if viewModel.recipes.isEmpty {
                        //empty if no error
                    VStack {
                        Image(systemName: "exclamationmark.circle")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 100, height: 100)
                            .foregroundStyle(.gray)
                        Text ("No Recipes Found!")
                            .font(.headline)
                            .foregroundStyle(.gray)
                    }
                    .padding()
                } else {
                    
                        List(viewModel.recipes) { recipe in
                            NavigationLink(destination: DetailedView(recipe: recipe)) {
                                HStack {
                                    CachedAsyncImage(url: recipe.photoURLSmall ?? "", placeholder: Image(systemName: "photo"))
                                        .scaledToFill()
                                        .frame(width: 75, height: 75)
                                        .clipShape(.circle)
                                    
                                    VStack (alignment: .leading) {
                                        Text (recipe.name)
                                            .font(.headline)
                                        Text (recipe.cuisine)
                                            .font(.subheadline)
                                            .foregroundStyle(.secondary)
                                    }
                                }
                            }
                        }
                        .navigationTitle("Cuisines! 👨‍🍳")
                        .task {
                            await viewModel.getReceipes()
                        }
                    }
                }
            
            .toolbar{
                ToolbarItem(placement: .topBarTrailing) {
                    Button(action: {
                        Task{
                            await viewModel.getReceipes()
                        }
                    }) {
                        Image(systemName: "arrow.clockwise")
                    }
                }
            }
        }
    }
}
    
    
    #Preview {
        ContentView()
    }
    
