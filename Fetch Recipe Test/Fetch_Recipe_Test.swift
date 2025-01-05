//
//  Fetch_Recipe_Test.swift
//  Fetch Recipe Test
//
//  Created by Pedro Romero on 1/5/25.
//

//will test 

import XCTest
@testable import Fetch_Recipe_App

final class RecipeViewModelTests: XCTestCase {
    var viewModel: recipeView!

    override func setUp() {
        super.setUp()
        viewModel = recipeView()
    }

    override func tearDown() {
        viewModel = nil
        super.tearDown()
    }

    func testFetchValidRecipes() async throws {
        await viewModel.getReceipes()
        XCTAssertFalse(viewModel.recipes.isEmpty, "Recipes should not be empty for valid data.")
        XCTAssertNil(viewModel.errorMessage, "Error message should be nil for valid data.")
    }

    func testFetchEmptyRecipes() async throws {
        viewModel.url = URL(string: "https://d3jbb8n5wk0qxi.cloudfront.net/recipes-empty.json")!
        await viewModel.getReceipes()
        XCTAssertTrue(viewModel.recipes.isEmpty, "Recipes should be empty for empty data.")
    }

    func testFetchMalformedRecipes() async throws {
        viewModel.url = URL(string: "https://d3jbb8n5wk0qxi.cloudfront.net/recipes-malformed.json")!
        await viewModel.getReceipes()
        XCTAssertTrue(viewModel.recipes.isEmpty, "Recipes should be empty for malformed data.")
        XCTAssertNotNil(viewModel.errorMessage, "Error message should be set for malformed data.")
    }
}
