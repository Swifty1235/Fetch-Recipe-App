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
            .navigationTitle("Recipes")
            .task {
                await viewModel.getReceipes()
            }
        }
        
    }
}

#Preview {
    ContentView()
}
