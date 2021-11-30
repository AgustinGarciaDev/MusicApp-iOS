

import Foundation


struct SongsList : Codable {
    
    let songs : [Track]
}

struct Account {
    let user: String
    let password: String
}
struct Track : Codable , Hashable{
    let song_id: String
    let title: String
    let artist: String?
    let genre : generoMusicales?
    let duration: Double?
    let album : String?
    
   
}

enum generoMusicales: String, Codable {
    case Rock = "Rock"
    case vacio = ""
}


struct register {
    let user1: Account = Account(user:"agustinch@gmail.com", password:"holasw123456")
}

var misTracks = [Track]()
//let misTracks = [
//    Track(song_id: "1", title:"Oro negro", artists: "Traje unos tangos", genre: "YSY A" , duration: nil, album: nil),
//
//]



enum PlayerStates {
    case play
    case stop
    case next
    case previous
}
