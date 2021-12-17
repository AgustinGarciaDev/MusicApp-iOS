//
//  SignInModel.swift
//  Naranja Music
//
//  Created by Agustin Chinchilla on 30/11/2021.
//

import Foundation


class SignInModel {
        
    let userOne : Account = Account(user:"agustinch@gmail.com", password:"Hola12345678")
   
    
    func validateFields(userName:String, passwordUser:String) -> String{
        
        var mensaje : String?
    
        let patron = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,20}"
        
        let regExp = try! NSRegularExpression(pattern: patron, options: [])
            let coincidencias = regExp.matches(in: userName, options: [], range: NSRange(location: 0, length: userName.count))

        if userName.isEmpty {
            mensaje = "Campo de correo vacio"
        }else if coincidencias.count != 1  {
            mensaje = "Email invalido no tine @ o mas de 10 caracteres"
        }else if  passwordUser.count < 10 {
            mensaje = "Password contiene menos de 10 caracteres"
        }else if passwordUser.isEmpty {
            mensaje = "Campo password vacio"
        }
      
        print(userName)
        print(passwordUser)
        if(userOne.user == userName &&  userOne.password == passwordUser){
            print("es igual")
            mensaje = "Usuario Existente"
        }else{
            mensaje = "Esta cuenta no existe"
        }
    
        
        return mensaje ?? "Logueado"
    }
    
    
    
}

