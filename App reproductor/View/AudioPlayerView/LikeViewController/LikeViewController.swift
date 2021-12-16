//
//  LikeViewController.swift
//  Naranja Music
//
//  Created by Agustin Chinchilla on 05/12/2021.
//

import Foundation


class LikeViewController : UIView {
    
    var isLove : Bool = true
    
  
    var titleView : UILabel = {
        let label = UILabel()
        label.text =  "Loved"
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 26)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false

        return label
    }()
    var image : UIImageView =  {
        let imgView = UIImageView()
        imgView.image =  UIImage(systemName: "heart" )
        imgView.translatesAutoresizingMaskIntoConstraints = false
        return imgView
    }()
    
    var close : UIButton = {
        let btn = UIButton()
        btn.setTitle("Dismiss", for: .normal)
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    
    
   
    
    override init (frame : CGRect) {
     super.init(frame : frame)
        self.backgroundColor = .orange
        self.frame = CGRect(x: 60, y: 210, width: 305, height: 305)
        self.layer.cornerRadius = 20

       
        
        self.addSubview(titleView)
        NSLayoutConstraint.activate([
            titleView.topAnchor.constraint(equalTo: self.topAnchor, constant:5),
            titleView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 5),
            titleView.widthAnchor.constraint(equalToConstant: 300)
        ])
        
        self.addSubview(image)
        NSLayoutConstraint.activate([
            image.topAnchor.constraint(equalTo: titleView.bottomAnchor, constant:5),
            image.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 45),
            image.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant:  -45),
            image.widthAnchor.constraint(equalToConstant: 70),
            image.heightAnchor.constraint(equalToConstant: 150)
        ])
        
        close.addTarget(self, action: #selector(closeModal), for: .touchUpInside)
        self.addSubview(close)
        NSLayoutConstraint.activate([
            close.topAnchor.constraint(equalTo: image.bottomAnchor, constant:30),
            close.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -10),
            close.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 30),
            close.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -30)
        ])
    }
    
    @objc   func closeModal(){
        self.removeFromSuperview()
        self.isLove = !self.isLove
        if(self.isLove == true){
            titleView.text = "Love"
            image.image =  UIImage(systemName: "heart" )
        }else {
            titleView.text = "Unlove"
            image.image =  UIImage(systemName: "heart.slash")

        }
      
    }
    required init?(coder aDecoder: NSCoder) {
       super.init(coder: aDecoder)
        
    }
}
