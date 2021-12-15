//
//  UIViewController+Extension.swift
//  Naranja Music
//
//  Created by Agustin Chinchilla on 06/12/2021.
//

import Foundation


extension UIViewController {
    
    func alertModal(_ message: String?){
        let alert = UIAlertController(title: "", message: message! , preferredStyle: UIAlertController.Style.alert)
                alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
                self.present(alert, animated: true, completion: nil)
    }
}
