//
//  TrackTableViewCell+Extension.swift
//  Naranja Music
//
//  Created by Agustin Chinchilla on 01/12/2021.
//

import Foundation

extension TrackTableViewCell : TrackViewCellProtocol {
    func actionButton(_ celda : UITableViewCell) {
        guard let parent = parent else { return }
        parent.buttonTouchedOnCell(celda: celda)

    }
    func changeTextLabel(_ cancion: Track) {
        titulo.text = cancion.title
        artista.text = cancion.artist
    }
   
}
