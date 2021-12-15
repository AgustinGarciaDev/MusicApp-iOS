//
//  enum.swift
//  Naranja Music
//
//  Created by Agustin Chinchilla on 04/12/2021.
//

import Foundation

private var viewController = AudioPlayerViewController()


protocol opcionesDeMenu {
    func borrarCancion(_ song : Track)
    func descargarCancion()
    func agregarAplaylist(_ song : Track)
    func compartirCancion()
    func likearCancion()
}

enum btnMenuOptions : opcionesDeMenu{
   
    case trash
    case download
    case addPlaylist
    case shareSong
    case love
    
}


extension btnMenuOptions {
    func borrarCancion(_ song : Track) {
        misTracks =  misTracks.filter{$0.title != song.title}
    }
    
    func descargarCancion() {
        DownloadManager.shared.startDownload(URL(string: "https://speed.hetzner.de/100MB.bin")!)
    }
    
    func agregarAplaylist(_ song : Track) {
        songs.insert(song)
        songsArray = Array(songs)
    }
    
    func compartirCancion() {
        print("Share cancion")

    }
    
    func likearCancion() {
        print("Likear cancion")
    }
}
