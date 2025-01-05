//
//  Fetch_Recipe_Test.swift
//  Fetch Recipe Test
//
//  Created by Pedro Romero on 1/5/25.
//
//  This file contains unit tests for the `recipeView` ViewModel, validating its behavior
//  when fetching recipes from various endpoints. It ensures proper handling of valid data,
//  empty data, and malformed data, while also checking error handling and state updates.
//

import XCTest
@testable import Fetch_Recipe_App

final class RecipeViewModelTests: XCTestCase {
    var viewModel: recipeView!

    override func setUp() async throws {
        try await super.setUp()
        // Initialize `recipeView` in the main actor context
        viewModel = await MainActor.run { recipeView() }
    }

    override func tearDown() async throws {
        viewModel = nil
        try await super.tearDown()
    }

    @MainActor
    func testFetchValidRecipes() async throws {
        await viewModel.getReceipes()
        XCTAssertFalse(viewModel.recipes.isEmpty, "Recipes should not be empty for valid data.")
        XCTAssertNil(viewModel.errorMessage, "Error message should be nil for valid data.")
    }

    @MainActor
    func testFetchEmptyRecipes() async throws {
        viewModel.url = URL(string: "https://d3jbb8n5wk0qxi.cloudfront.net/recipes-empty.json")!
        await viewModel.getReceipes()
        XCTAssertTrue(viewModel.recipes.isEmpty, "Recipes should be empty for empty data.")
    }

    @MainActor
    func testFetchMalformedRecipes() async throws {
        viewModel.url = URL(string: "https://d3jbb8n5wk0qxi.cloudfront.net/recipes-malformed.json")!
        await viewModel.getReceipes()
        XCTAssertTrue(viewModel.recipes.isEmpty, "Recipes should be empty for malformed data.")
        XCTAssertNotNil(viewModel.errorMessage, "Error message should be set for malformed data.")
    }
}
