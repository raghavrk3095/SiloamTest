//
//  CommonStrings.swift
//  Siloam Test
//
//  Created by Apple on 12/08/23.
//

import Foundation

struct CommonStrings {
    static let emptyUname = "Please enter username"
    static let emptyPass = "Please enter password"
    static let wrongCreds = "Wrong username and password"
    static let loginSuccessful = "Login successful"
    static let compName = "SiloamHospitals"
    static let eyeSlashImageName = "eye.slash.fill"
    static let eyeImageName = "eye.fill"
    static let placehodlerImage = "placeholder"
    static let failedToRetrieveCreds = "Failed to retrieve credentials"
    static let credsSaved = "Credentials saved"
    static let failedToSaveCreds = "Failed to save credentials"
    static let mealName = "Name - "
    static let mealCategory = "Category - "
    static let mealArea = "Area - "
    static let mealTags = "Tags - "
    static let instructions = "Instructions"
    static let meals = "Meals"
}

struct StoryboardName {
    static let main = "Main"
}

struct ControllerName {
    static let signUpController = "SignUpViewController"
    static let loginController = "LoginViewController"
    static let mealViewController = "MealViewController"
    static let mealDetailController = "MealDetailViewController"
    static let fullScreenImageViewController = "FullScreenImageViewController"
}

struct CellIdentifiers {
    static let mealsTableViewCell = "MealsTableViewCell"
    static let mealImageDetailTableViewCell = "MealImageDetailTableViewCell"
    static let mealNameDetailTableViewCell = "MealNameDetailTableViewCell"
    static let mealInstructionsDetailTableViewCell = "MealInstructionsDetailTableViewCell"
    static let mealDetailHeaderCell = "MealDetailHeaderCell"
}

struct APIUrls {
    static let baseUrl = "https://www.themealdb.com/api/json/v1/1"
    static let searchFirstLetterUrl = "/search.php"
    static let mealDetailUrl = "/lookup.php"
}

struct AccessibilityIdentifier {
   static let loaderView = "LoaderView"
   static let loaderIndicator = "LoaderIndicator"
}
