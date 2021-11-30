//
//  ButtonUIButton.swift
//  Naranja Music
//
//  Created by Agustin Chinchilla on 23/11/2021.
//

import UIKit

class ButtonUIButton: UIButton {

    var icon : UIImage?
    var secondIcon: UIImage?
    var isPlaying: Bool = false
    
  
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        self.layer.cornerRadius = self.frame.width/2
        self.clipsToBounds = true
        self.tintColor = .black
    }

    func performTwoStateSelection(){
        self.isPlaying = !isPlaying
//        print(isPlaying)
        self.setImage(isPlaying ? icon : secondIcon , for: .normal)
        self.setImage(isPlaying ? icon : secondIcon , for: .highlighted)
    }
    
     func imgBtn(icon: UIImage?) {
        guard let icon = icon else {return}
        self.icon = icon
        self.setImage(icon , for: .normal)
        self.setImage(icon, for: .highlighted)
    }

}
