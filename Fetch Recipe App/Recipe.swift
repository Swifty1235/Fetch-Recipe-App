//
//  Recipe.swift
//  Fetch Recipe App
//
//  Created by Pedro Romero on 1/3/25.
//


import Foundation

struct Recipe: Identifiable, Codable {
    let id: UUID
    let name: String
    let cuisine: String
    let photoURLSmall: String?
    
    enum CodingKeys: String, CodingKey {
        case id = "uuid"
        case name
        case cuisine
        case photoURLSmall = "photo_url_small"
    }
}
