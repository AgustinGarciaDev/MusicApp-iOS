

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


var misTracks = [Track]()
var songsArray = [Track]()

enum PlayerStates {
    case play
    case stop
    case next
    case previous
}
