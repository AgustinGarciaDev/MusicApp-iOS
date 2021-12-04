//
//  APIManager.swift
//  Naranja Music
//
//  Created by Agustin Chinchilla on 18/11/2021.
//

import Foundation
import Network

class APIManager {
    
    var monitor : NWPathMonitor!
    
    let baseUrl = "https://raw.githubusercontent.com/beduExpert/Swift-Proyecto/main/API/db.json"
    
    static let shared = APIManager()

    
    func getMusic(completion: @escaping ([Track]? , Error?) -> ()){
        
        
        if !checkConnectivity() {
                    completion(nil, NSError(domain: Bundle.main.bundleIdentifier!, code: 504, userInfo:nil))
                    return
        }
        
        
        guard let url : URL = URL(string: baseUrl) else {
            completion(nil, NSError(domain: Bundle.main.bundleIdentifier!, code: 500, userInfo:nil))
            return
        }
       
        let request: NSMutableURLRequest = NSMutableURLRequest(url: url)
        request.httpMethod = "GET"
        let session = URLSession.shared
        
        let task = session.dataTask(with: request as URLRequest, completionHandler: {datos, response, error -> Void in
            
            if(error != nil){
                completion(nil, error!)
            }else {
                if let data = datos {
                    do {

                        let json = try JSONSerialization.jsonObject(with: data , options: .allowFragments) as! [String:Any]
                        let songs = json["songs"] as! [[String:Any]]
                        let soungData = try JSONSerialization.data(withJSONObject: songs, options: .fragmentsAllowed)
                        let result = try JSONDecoder().decode([Track].self, from:soungData)
                        completion(result, nil)
                    }
                    catch {
                        print(String(describing: error))
                    }
                }
            }
            
        })
        
        task.resume()
        
    }
    
func checkConnectivity() -> Bool {
    var monitor:NWPathMonitor!
    monitor = NWPathMonitor()
    var internetEstatus = true
    monitor.pathUpdateHandler = { Path in
                    
                    if Path.status == .satisfied {
                        internetEstatus = false
                    }

                }
        monitor.start(queue: DispatchQueue.global())
                return internetEstatus
    }
    
}
