//
//  TrackTableViewCell+Extension.swift
//  Naranja Music
//
//  Created by Agustin Chinchilla on 01/12/2021.
//

import Foundation

extension TrackTableViewCell : TrackViewCellProtocol {
    func actionButton(_ button:ButtonUIButton) {
        guard let parent = parent else { return }
        parent.buttonTouchedOnCell(celda: self)
        button.performTwoStateSelection()
    }
    func changeTextLabel(_ cancion: Track) {
        titulo.text = cancion.title
        artista.text = cancion.artist
    }
}
