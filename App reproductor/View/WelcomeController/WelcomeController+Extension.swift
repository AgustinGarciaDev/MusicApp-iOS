//
//  WelcomeController+Extension.swift
//  Naranja Music
//
//  Created by Agustin Chinchilla on 15/12/2021.
//
import UIKit
import Foundation


extension WelcomeController {
    
    func addGesture() {
        let gesture = UITapGestureRecognizer(target: self,action:#selector(handleTap))
        let gesturePinch = UIPinchGestureRecognizer(target: self, action: #selector(handlePich(_:)))
        
        self.logo.addGestureRecognizer(gesture)
        self.logo.addGestureRecognizer(gesturePinch)
        self.logo.isUserInteractionEnabled = true
    }
    @IBAction func logout(_ sender: Any) {
        viewModel?.welcomeViewDelegate?.signOut()
    }
    
    @objc func handleTap(){
        viewModel?.welcomeViewDelegate?.handleTapAnimation()
    }

    @objc func handlePich(_ sender: UIPinchGestureRecognizer){
        viewModel?.welcomeViewDelegate?.handlePichAnimation(sender)
    }
}

extension WelcomeController : WelcomeViewDelegate  {
    func signOut() {
        dismiss(animated: true, completion: nil)
    }
    
    func handleTapAnimation() {
        
        var  infoModal = InfoModal()
        infoModal.changeValue()
    
        let message = "Copyright 2021 \n \(infoModal.name!) \n Version \(infoModal.version!) (\(infoModal.compilado!))"
        self.alertModal(message)
    }
    
    func handlePichAnimation(_ sender: UIPinchGestureRecognizer) {
        if let scale = (sender.view?.transform.scaledBy(x: sender.scale, y: sender.scale)) {
                   guard scale.a > 1.0 else { return }
                   guard scale.d > 1.0 else { return }
                    sender.view?.transform = scale
                   sender.scale = 1.0
        }
    }
    
    
 
}

