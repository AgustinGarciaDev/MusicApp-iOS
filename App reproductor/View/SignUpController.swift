//
//  SignUpController.swift


import UIKit

class SignUpController: UIViewController {

   
    
    @IBOutlet weak var TextFieldUserName: UITextField!
    @IBOutlet weak var TextFieldPassword: UITextField!
    @IBOutlet weak var botonFacebook: UIButton!
    @IBOutlet weak var titulo: UILabel!
    
    var viewModel : SignInModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = SignInModel()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    @IBAction func dismiss(_ sender: Any){
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func `continue`(_ sender: Any) {
        
        var textFieldUser:String?
        var textFieldPass:String?
        
        textFieldUser = TextFieldUserName.text
        textFieldPass = TextFieldPassword.text
        
        guard let userName = textFieldUser , let userPassword = textFieldPass else {
            return
        }

        let mensaje = viewModel?.validateFields(userName: userName , passwordUser: userPassword)
        
        if mensaje != "Logueado" {
            let alert = UIAlertController(title: "", message: mensaje , preferredStyle: UIAlertController.Style.alert)
                    alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
                    self.present(alert, animated: true, completion: nil)
        }
        if mensaje == "Logueado"{
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
