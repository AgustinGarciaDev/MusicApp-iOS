//
//  SignInController.swift
//  App reproductor
//
//  Created by Agustin Chinchilla on 26/10/2021.
//

import UIKit

class SignInController: UIViewController {
    

    @IBOutlet weak var textFieldUserName: UITextField!
    @IBOutlet weak var textFieldUserPasswork: UITextField!
    @IBOutlet weak var titulo: UILabel!
    
    var viewModel : SignInModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = SignInModel()

    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }

  
    
    @IBAction func `continue`(_ sender: Any) {
        
        var textFieldUser:String?
        var textFieldPass:String?
        
        textFieldUser = textFieldUserName.text
        textFieldPass = textFieldUserPasswork.text
        
        guard let userName = textFieldUser , let userPassword = textFieldPass else {
            return
        }

        let mensaje = viewModel?.validateFields(userName: userName , passwordUser: userPassword)
        
        if mensaje != "Logueado" && mensaje != "Usuario Existente" {
            let alert = UIAlertController(title: "", message: mensaje , preferredStyle: UIAlertController.Style.alert)
                    alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
                    self.present(alert, animated: true, completion: nil)
        }
        if mensaje == "Usuario Existente"{
            goToWelcomeController()
        }
        
    }
    func goToWelcomeController() {
      let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "TabBarNavegation") as? UITabBarController
        vc?.modalPresentationStyle = .fullScreen
        guard let vc = vc else {return}
      self.present(vc, animated: true)
    }
    
    }
    


 
