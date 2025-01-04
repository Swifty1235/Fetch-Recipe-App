//
//  Gets_Recipes.swift
//  Fetch Recipe App
//
//  Created by Pedro Romero on 1/3/25.
//

import Foundation

@MainActor
class recipeView: ObservableObject {
    @Published var recipes: [Recipe] = []
    @Published var errorMessage: String?
    
    private let url = URL(string: "https://d3jbb8n5wk0qxi.cloudfront.net/recipes.json")!
    
    func getReceipes()async {
        do{
            let (data, _) = try await URLSession.shared.data(from: url)
            let decodedResponse = try JSONDecoder().decode([String: [Recipe]].self, from: data)
            recipes = decodedResponse["recipes"] ?? []
        }catch{
            //Gives error message
            errorMessage = "Failed to load the recipe: \(error.localizedDescription)"
        }
    }
}
