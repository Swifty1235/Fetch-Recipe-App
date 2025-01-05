//
//  ContentView.swift
//  Fetch Recipe App
//
//  Created by Pedro Romero on 1/3/25.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel = recipeView()
    @State private var isLoading = false
    
    var body: some View {
        NavigationView{
            ZStack {
                // Gradient background
                LinearGradient(
                    gradient: Gradient(colors: [Color.blue.opacity(0.1), Color.purple.opacity(0.2)]),
                    startPoint: .top,
                    endPoint: .bottom
                )
                .edgesIgnoringSafeArea(.all)
                
                VStack {
                    if let errorMessage = viewModel.errorMessage {
                        Text(errorMessage)
                            .foregroundStyle(.red)
                            .multilineTextAlignment(.center)
                            .font(.title2)
                            .padding(.horizontal)
                            .padding(.vertical, 16)
                    }else if viewModel.recipes.isEmpty {
                        //empty if no error
                        VStack(spacing: 16) {
                            Image(systemName: "exclamationmark.circle")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 100, height: 100)
                                .foregroundStyle(.gray)
                                .shadow(radius: 5)
                            Text("No Recipes Found!")
                                .font(.title3)
                                .foregroundStyle(.secondary)
                        }
                        .padding()
                    } else {
                        List(viewModel.recipes) { recipe in
                            NavigationLink(destination: DetailedView(recipe: recipe)) {
                                HStack(spacing: 16) {
                                    // Recipe Image
                                    CachedAsyncImage(
                                        url: recipe.photoURLSmall ?? "",
                                        placeholder: Image(systemName: "photo")
                                    )
                                    .frame(width: 75, height: 75)
                                    .clipShape(Circle())
                                    .shadow(radius: 4) // addition of shadows, nice effect
                                    
                                    // Recipe Details
                                    VStack(alignment: .leading, spacing: 8) {
                                        Text(recipe.name)
                                            .font(.headline)
                                            .fontWeight(.bold)
                                        
                                        Text(recipe.cuisine)
                                            .font(.subheadline)
                                            .foregroundColor(.secondary)
                                    }
                                }
                                .padding(.vertical, 6) // Add spacing between list rows
                            }
                            .listRowBackground(
                                LinearGradient(
                                    gradient: Gradient(colors: [Color.white, Color.blue.opacity(0.1)]),
                                    startPoint: .init(x: 0, y: 2),
                                    endPoint: .trailing
                                )
                            )                         }
                        .listStyle(.plain) // Ensure a clean, modern list style
                        .navigationTitle("Cuisines! 👨‍🍳")
                        .task {
                            await viewModel.getReceipes()
                        }
                    }
                }
                .toolbar {
                    ToolbarItem(placement: .topBarTrailing) {
                        Button(action: {
                            Task {
                                isLoading = true
                                await viewModel.getReceipes()
                                isLoading = false
                            }
                        }) {
                            Image(systemName: "arrow.clockwise")
                                .font(.title2)
                                .foregroundColor(.blue)
                                .rotationEffect(.degrees(isLoading ? 2000 : 0))
                                .animation(.easeInOut(duration: 0.5), value: isLoading)
                        }
                    }
                }
            }
        }
    }
}


#Preview {
    ContentView()
}

