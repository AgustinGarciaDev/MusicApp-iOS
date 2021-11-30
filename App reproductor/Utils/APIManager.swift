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
    
    let baseUrl = "https://raw.githubusercontent.com"
    static let shared = APIManager()
    static let getMusicEndpoint = "/beduExpert/Swift-Proyecto/main/API/db.json"
    
    func getMusic(completion: @escaping ([Track]? , Error?) -> ()){
        let url : String = baseUrl + APIManager.getMusicEndpoint
        
        let request :NSMutableURLRequest = NSMutableURLRequest(url: NSURL(string: url)! as URL)
        request.httpMethod = "GET"
        
        let session = URLSession.shared
        
        let task = session.dataTask(with: request as URLRequest, completionHandler: {datos, response, error -> Void in
            
            if(error != nil){
//               misTracks = []\
                completion(nil, error!)
            }else {
                if let data = datos {
                    do {

                        let json = try JSONSerialization.jsonObject(with: data , options: .allowFragments) as! [String:Any]
                        let songs = json["songs"] as! [[String:Any]]
                        let soungData = try JSONSerialization.data(withJSONObject: songs, options: .fragmentsAllowed)
                        let result = try JSONDecoder().decode([Track].self, from:soungData)
                        completion(result, nil)

//                        misTracks = result
                    }
                    catch {
                        print(String(describing: error))
                    }
                }
            }
            
        })
        
        task.resume()
        
    }
    
    func red () {
        
        monitor = NWPathMonitor()
        monitor.pathUpdateHandler = { Path in
                    var internetEstatus = 1
                    if Path.status == .satisfied {
                        if Path.isExpensive { // Datos celulares
                            internetEstatus = 0 // Si hay una conexion pero son datos celulares
                        }
                        else {
                            print("Hay internet")
                           
                        }
                    }
                    else {
                        internetEstatus = -1 // No hay internet
                    }
            
                    if internetEstatus != 1 { // No hay internet o es solo celular
                        
                    }else{
                       print("hay internet")
                    }
                } // closure: bloque de código, que se puede usar como una variable
                let elKiu = DispatchQueue (label: "NetworkMonitor")
                monitor.start(queue: elKiu)
    }
    
}
