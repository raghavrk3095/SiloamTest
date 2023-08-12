//
//  MealsListModel.swift
//  Siloam Test
//
//  Created by Apple on 12/08/23.
//

import Foundation

struct MealsListModel: Decodable {
    let meals: [MealsListDetailModel]?
    
    enum CodingKeys: String, CodingKey {
        case meals
    }
}

struct MealsListDetailModel: Decodable {
    let mealId: String?
    let mealName: String?
    let mealCategory: String?
    let mealArea: String?
    let mealInstuctions: String?
    let mealThumbImage: String?
    let mealTags: String?
    
    enum CodingKeys: String, CodingKey {
        case mealId = "idMeal"
        case mealName = "strMeal"
        case mealCategory = "strCategory"
        case mealArea = "strArea"
        case mealInstuctions = "strInstructions"
        case mealThumbImage = "strMealThumb"
        case mealTags = "strTags"
    }
}
