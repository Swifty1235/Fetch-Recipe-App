//
//  Gets_Recipes.swift
//  Fetch Recipe App
//
//  Created by Pedro Romero on 1/3/25.
//

import Foundation

@MainActor
class RecipeViewModel: ObservableObject {
    @Published var recipes: [Recipe] = []
    @Published var errorMessage: String?
    
    func getReceipes()async {
        do{
            let (data, _ ) try await URLSession.shared.data(from: URL)
            let decodedResponse = try JSONDecoder().decode([String: [Recipe]])
    }
}
