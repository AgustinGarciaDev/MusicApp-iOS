

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
    let genre : String?
    let album : String?
    var downloading: Bool?
}



var misTracks = [Track]()
var songsArray = [Track]()
var songs = Set<Track>()

enum PlayerStates {
    case play
    case stop
    case next
    case previous
}
