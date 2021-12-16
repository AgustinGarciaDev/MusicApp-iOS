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
    
    var viewModel:WelcomeViewModel?


    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = WelcomeViewModel()
        viewModel?.welcomeViewDelegate = self
        self.addGesture()
        

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        logo.image = UIImage(named: "logoNotBackground")
    }
    
}
