

import Foundation

struct Account {
    let user: String
    let password: String
}
struct Track {
    let title: String
    let album : String
    let artists: String
}

struct register {
    let user1: Account = Account(user:"agustinch@gmail.com", password:"holasw123456")
}
let misTracks = [
    Track(title: "Traje unos tangos", album:"Modo diablo", artists: "YSY A"),
    Track(title: "Oro negro", album:"Modo diablo", artists: "Modo diablo"),
   Track(title: "Keloke", album:"Modo diablo", artists: "Khea"),
   Track(title: "Quavo", album:"Modo diablo", artists: "Modo diablo"),
    Track(title: "Traje unos tangos", album:"Modo diablo", artists: "YSY A"),
    Track(title: "Oro negro", album:"Modo diablo", artists: "Modo diablo"),
   Track(title: "Keloke", album:"Modo diablo", artists: "Khea"),
   Track(title: "Quavo", album:"Modo diablo", artists: "Modo diablo"),
]
