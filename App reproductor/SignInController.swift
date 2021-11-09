//
//  SignInController.swift
//  App reproductor
//
//  Created by Agustin Chinchilla on 26/10/2021.
//

import UIKit

class SignInController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }

    @IBOutlet weak var textFieldUserName: UITextField!
    @IBOutlet weak var textFieldUserPasswork: UITextField!
    @IBOutlet weak var titulo: UILabel!
    
    @IBAction func `continue`(_ sender: Any) {
        
        let model : register = register()
        var tipoError : Int = 0
        var textFieldUser:String?
        
        textFieldUser = textFieldUserName.text
        var textFieldPass:String?
        textFieldPass = textFieldUserPasswork.text
        
        guard let userName = textFieldUser , let userPassword = textFieldPass else {
            return
        }
        tipoError = validator(userName: userName, passwordUser:userPassword)
        
        switch tipoError {
            case 1 :
                print("Campo correo vacio")
            case 2:
                print("Email invalido no tine @ o mas de 10 caracteres")
            case 3 :
                print("Campo password vacio")
            case 4 :
                print("Password contiene menos de 10 caracteres")
            default :
                searchUser()
        }
        
        func searchUser (){
            if(model.user1.user == userName && model.user1.password == userPassword){
                goToTableController()
            }
        }
        
       
    }
    
    func validator(userName:String, passwordUser:String) ->Int {
        
        var numberError : Int = 0
        
        let patron = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,20}"
        
        let regExp = try! NSRegularExpression(pattern: patron, options: [])
            let coincidencias = regExp.matches(in: userName, options: [], range: NSRange(location: 0, length: userName.count))
        
        if userName.isEmpty {
            numberError = 1
        }else if coincidencias.count != 1  {
            print("entro")
            print(coincidencias.count)
            numberError = 2
        }else if  passwordUser.count < 10 {
                numberError = 4
        }else if passwordUser.isEmpty {
            numberError = 3
        }
        
        return numberError
    
    }
    
    @IBAction func `continueLogin`(_ sender: Any) {
        print(#function)
    }
    
    func goToTableController() {
      let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "TracksTableViewController") as? TracksTableViewController
        vc?.modalPresentationStyle = .fullScreen
        guard let vc = vc else {return}
      self.present(vc, animated: true)
    }

}
