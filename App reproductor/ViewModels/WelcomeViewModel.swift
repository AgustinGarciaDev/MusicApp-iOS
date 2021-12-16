//
//  WelcomeViewModel.swift
//  Naranja Music
//
//  Created by Agustin Chinchilla on 15/12/2021.
//

import Foundation

struct InfoModal {
    var version : String?
    var compilado: String?
    var name:String?
    
    mutating func changeValue(){
        version = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String
        
        compilado = Bundle.main.infoDictionary?["CFBundleVersion"] as? String
        
        name = Bundle.main.infoDictionary?["CFBundleName"] as? String
    }
}

protocol WelcomeViewDelegate {
    func handleTapAnimation()
    func handlePichAnimation(_ sender: UIPinchGestureRecognizer)
    func signOut()
}


class WelcomeViewModel  {
    var welcomeViewDelegate : WelcomeViewDelegate?
    
    
}
