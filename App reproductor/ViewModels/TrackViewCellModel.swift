//
//  TrackViewCellModel.swift
//  Naranja Music
//
//  Created by Agustin Chinchilla on 01/12/2021.
//

import Foundation

protocol TrackViewCellProtocol {
    
    func changeTextLabel(_ cancion: Track)
    func actionButton(_ button: ButtonUIButton)
}
class TrackViewCellModel {
    
    var trackViewDelegate :TrackViewCellProtocol?
    
}
