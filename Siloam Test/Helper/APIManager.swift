//
//  APIManager.swift
//  Siloam Test
//
//  Created by Apple on 13/08/23.
//

import Foundation
import Alamofire

class APIManager {
    static func callMealsListApi(apiUrl: String, params: [String:Any]?, headers: HTTPHeaders?, completion: @escaping(DataResponse<MealsListModel, AFError>) -> Void) {
        AF.request(apiUrl, method: .get, parameters: params, encoding: URLEncoding.default, headers: headers).responseDecodable(of: MealsListModel.self) { response in
            completion(response)
        }
    }
    
    static func callMealDetailApi(apiUrl: String, params: [String: Any]?, headers: HTTPHeaders?, completion: @escaping(DataResponse<MealsListModel, AFError>) -> Void) {
        AF.request(apiUrl, method: .get, parameters: params, encoding: URLEncoding.default, headers: headers).responseDecodable(of: MealsListModel.self) { response in
            completion(response)
        }
    }
}
