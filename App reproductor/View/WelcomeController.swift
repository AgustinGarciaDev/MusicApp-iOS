//
//  WelcomeController.swift
//  Naranja Music
//
//  Created by Agustin Chinchilla on 30/10/2021.
//

import UIKit

class WelcomeController: UIViewController {

    @IBOutlet weak var logo: UIImageView!
    @IBOutlet weak var logout: UIButton!
    @IBOutlet weak var titulo: UILabel!
    
    @IBOutlet var pichGesture: UIPinchGestureRecognizer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let gesture = UITapGestureRecognizer(target: self,action:#selector(handleTap))
        let gesturePinch = UIPinchGestureRecognizer(target: self, action: #selector(handlePich(_:)))
        
        self.logo.addGestureRecognizer(gesture)
        self.logo.addGestureRecognizer(gesturePinch)
        self.logo.isUserInteractionEnabled = true

     
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        logo.image = UIImage(named: "logoNotBackground")
    }
    
    @IBAction func logout(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @objc func handleTap(){

        let version = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String
        let compilado = Bundle.main.infoDictionary?["CFBundleVersion"] as? String
        let nameAplicacion = Bundle.main.infoDictionary?["CFBundleName"] as? String

        let message = "Copyright 2021 \n \(nameAplicacion!) \n Version \(version!) (\(compilado!))"
        self.alertModal(message)
    }

    @objc func handlePich(_ sender: UIPinchGestureRecognizer){
        if let scale = (sender.view?.transform.scaledBy(x: sender.scale, y: sender.scale)) {
                   guard scale.a > 1.0 else { return }
                   guard scale.d > 1.0 else { return }
                    sender.view?.transform = scale
                   sender.scale = 1.0
        }
    }

    

    
}
