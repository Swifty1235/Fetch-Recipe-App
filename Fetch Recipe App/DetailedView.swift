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
            ZStack{
                AsyncImage(url: URL(string: recipe.photoURLLarge ?? "")) {
                    image in image
                        .resizable()
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .blur(radius: 40)
                        .opacity(0.5)
                } placeholder: {
                    Color.gray
                }
                .frame(height: UIScreen.main.bounds.height * 2 / 3)
                .edgesIgnoringSafeArea(.all)
                
                VStack {
                    AsyncImage(url: URL(string: recipe.photoURLLarge ?? "")) {
                        image in image
                            .resizable()
                            .scaledToFit()
                        
                    } placeholder: {
                        Color.gray
                            .frame(maxWidth: 200)
                    }
                    .padding(.bottom, 50)
                    
                    Text("Cuisine Type: \(recipe.cuisine)")
                        .font(.title)
                        .italic()
                        .foregroundColor(.primary)
                        .padding(.horizontal)
                    
                    if let sourceURL = recipe.sourceURL {
                        Button(action: {
                            if let url = URL(string: sourceURL) {
                                UIApplication.shared.open(url)
                            }
                        }) {
                            HStack {
                                Image(systemName: "book")
                                Text("View Recipe")
                            }
                            .font(.headline)
                            .foregroundColor(.white)
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color.blue)
                            .cornerRadius(10)
                        }
                        .padding(.horizontal)
                    }
                    
                    if let youtubeURL = recipe.youtubeURL {
                        Button(action: {
                            if let url = URL(string: youtubeURL) {
                                UIApplication.shared.open(url)
                            }
                        }) {
                            HStack {
                                Image(systemName: "play.rectangle")
                                Text("Watch Video")
                            }
                            .font(.headline)
                            .foregroundColor(.white)
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color.red)
                            .cornerRadius(10)
                        }
                        .padding(.horizontal)
                    }
                    
                    Spacer()
                }
                .padding()
            }
        }
        .navigationTitle(recipe.name)
        .navigationBarTitleDisplayMode(.inline) // Compact navigation title
    }
}


#Preview {
    ContentView()
}
