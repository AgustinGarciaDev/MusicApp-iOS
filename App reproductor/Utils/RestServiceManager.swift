//
//  RestServiceManager.swift
//  Naranja Music
//
//  Created by Agustin Chinchilla on 13/12/2021.
//

import Foundation
import Alamofire

class RestServiceManager {
    let baseUrl = "https://raw.githubusercontent.com/beduExpert/Swift-Proyecto/main/API"
    
 
    static let shared = RestServiceManager()
    
    func GoToInfo<T: Decodable>(responseType: T.Type , method: HTTPMethod , endpoint: String , completionHandler:@escaping(_ status:Bool , _ data : T?)->()) {
        Alamofire.Session.default.session.configuration.requestCachePolicy = .reloadIgnoringLocalCacheData
        var request = URLRequest(url: URL(string: "\(self.baseUrl)\(endpoint)")!)
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")

        
        AF.request(request)
            .validate(statusCode: 200..<300)
            .responseData { response in
                switch response.result {
                case .success(let value):
                    do{
                        let data = try JSONDecoder().decode(T.self, from: value)
                        completionHandler(true, data)
                    }catch{
                        print(error.localizedDescription)
                    }
                    break
                case .failure(let error):
                    print(error)
                    completionHandler(false, nil)
                    break
                }
            }


    }
    
    
}

