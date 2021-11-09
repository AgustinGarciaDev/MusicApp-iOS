//
//  SignUpController.swift


import UIKit

class SignUpController: UIViewController {

    override func viewDidLoad() {
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    
    @IBOutlet weak var TextFieldUserName: UITextField!
    @IBOutlet weak var TextFieldPassword: UITextField!
    @IBOutlet weak var botonFacebook: UIButton!
    
    @IBOutlet weak var titulo: UILabel!
    
    @IBAction func dismiss(_ sender: Any){
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func `continue`(_ sender: Any) {
        var tipoError : Int = 0
        var textFieldUser:String?
        textFieldUser = TextFieldUserName.text
        var textFieldPass:String?
        textFieldPass = TextFieldPassword.text
        
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
                goToWelcomeController()
        }
        
    }
    
    
    func validator(userName:String, passwordUser:String) ->Int {
        
        var numberError : Int = 0
        
        let patron = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,20}"
        
        let regExp = try! NSRegularExpression(pattern: patron, options: [])
            let coincidencias = regExp.matches(in: userName, options: [], range: NSRange(location: 0, length: userName.count))
        
        if userName.isEmpty {
            numberError = 1
        }else if   coincidencias.count != 1  {
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
    
    func goToWelcomeController() {
      let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "TabBarNavegation") as? UITabBarController
        vc?.modalPresentationStyle = .fullScreen
        guard let vc = vc else {return}
      self.present(vc, animated: true)
    }
}
