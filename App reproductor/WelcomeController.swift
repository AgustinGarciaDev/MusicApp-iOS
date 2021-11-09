//
//  WelcomeController.swift
//  Naranja Music
//
//  Created by Agustin Chinchilla on 30/10/2021.
//

import UIKit

class WelcomeController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    @IBAction func logout(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBOutlet weak var logo: UIImageView!
    
    @IBOutlet weak var logout: UIButton!
    
    @IBOutlet weak var titulo: UILabel!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        logo.image = UIImage(named: "logoApp")
    }
    
    
}
