//
//  CurrentSong.swift
//  Naranja Music
//
//  Created by Agustin Chinchilla on 19/11/2021.
//

import Foundation


class CurrentSong {
    
    var name  : String
    var genre : String
    
    init(name:String , genre:String){
        self.genre = genre
        self.name = name
    }
    
    func getSongName() -> String {
        return self.name
    }
}
