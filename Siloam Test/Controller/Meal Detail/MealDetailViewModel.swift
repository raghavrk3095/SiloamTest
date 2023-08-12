//
//  MealDetailViewModel.swift
//  Siloam Test
//
//  Created by Apple on 12/08/23.
//

import Foundation
import Alamofire

class MealDetailViewModel {
    
    // MARK: - Variables
    
    var meals: [MealsListDetailModel] = []
    var reloadTableViewClosure: (() -> ())?
    var showHideTableViewClosure: ((_ isShow: Bool) -> ())?
    
    // MARK: - Call meal list api
    
    func callMealDetailApi(mealId: String) {
        self.meals = []
        
        let parameters: [String:Any] = [
            "i" : mealId
        ]
        
        AF.request(APIUrls.baseUrl + APIUrls.mealDetailUrl, method: .get, parameters: parameters, encoding: URLEncoding.default, headers: nil, interceptor: nil, requestModifier: nil).responseDecodable(of: MealsListModel.self) { response in
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
