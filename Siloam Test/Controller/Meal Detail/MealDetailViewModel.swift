//
//  MealDetailViewModel.swift
//  Siloam Test
//
//  Created by Apple on 12/08/23.
//

import Foundation

class MealDetailViewModel {
    
    // MARK: - Variables
    
    var meals: [MealsListDetailModel] = []
    var reloadTableViewClosure: (() -> ())?
    var showHideTableViewClosure: ((_ isShow: Bool) -> ())?
    
    var updateLoadingStatus: (()->())?
    
    var isLoading: Bool = false {
        didSet {
            self.updateLoadingStatus?()
        }
    }
    
    // MARK: - Call meal list api
    
    func callMealDetailApi(mealId: String) {
        self.meals = []
        
        let parameters: [String:Any] = [
            "i" : mealId
        ]
        
        // show loader
        self.isLoading = true
        
        APIManager.callMealDetailApi(apiUrl: APIUrls.baseUrl + APIUrls.mealDetailUrl, params: parameters, headers: nil) { [weak self] response in
            guard let self = self else { return }
            
            // hide loader
            self.isLoading = false
            
            switch response.result {
            case .success(let meals):
                if let mealsList = meals.meals {
                    self.meals = mealsList
                    if self.meals.count == 1 {
                        self.showHideTableViewClosure?(true)
                        self.reloadTableViewClosure?()
                    }
                }
            case .failure(let error):
                print("Error is: \(error.localizedDescription)")
            }
        }
    }
}
