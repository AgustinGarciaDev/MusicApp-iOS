//
//  TrackViewCellModel.swift
//  Naranja Music
//
//  Created by Agustin Chinchilla on 01/12/2021.
//

import Foundation

protocol TrackViewCellProtocol {
    
    func changeTextLabel(_ cancion: Track)
    func actionButton( _ celda : UITableViewCell) 
    
}

protocol ButtonOnCellDelegate {
    func buttonTouchedOnCell(celda: UITableViewCell)
    func textAlert(_ message: String)
}




class TrackViewCellModel {
    
    var trackViewDelegate :TrackViewCellProtocol?
    
}
