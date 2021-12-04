//
//  DataManager.swift
//  Naranja Music
//
//  Created by Agustin Chinchilla on 18/11/2021.
//

import Foundation


class DataManager{
    static func cancionesPorGenero(song : [Track]) -> [Track]{
          return song.filter{$0.genre != nil}
       }
}
