//
//  TrackTableViewCell+Extension.swift
//  Naranja Music
//
//  Created by Agustin Chinchilla on 01/12/2021.
//

import Foundation

extension TrackTableViewCell : TrackViewCellProtocol {
    func menuButton() -> UIMenu {
        var menuItems: [UIAction] {
            return [

                UIAction(title: "Play", image: UIImage(systemName: "play.fill"), handler: { (_) in
                    self.viewModel?.trackViewDelegate?.actionButton(self)
                    self.btnPlay.performTwoStateSelection()
                }),
                UIAction(title: "Download", image: UIImage(systemName: "tray.and.arrow.down.fill"), handler: { (_) in
                    self.parent?.textAlert("Descargando")
                    self.statusDownload.isHidden = false
                    self.track?.downloading = true
                    misTracks[self.cellDownloading!].downloading = true
                    DownloadManager.shared.startDownload(URL(string: "https://speed.hetzner.de/100MB.bin")!)
                    
                    DownloadManager.shared.celda = ["celda" : self]
                }),
            ]
        }
        var demoMenu: UIMenu {
            return UIMenu(title: "", image: nil, identifier: nil, options: [], children: menuItems)
        }
        
        return demoMenu
    }
    
    
    
    func actionButton(_ celda : UITableViewCell) {
        guard let parent = parent else { return }
        parent.buttonTouchedOnCell(celda: celda)

    }
    
    func changeTextLabel(_ cancion: Track) {
        titulo.text = cancion.title
        artista.text = cancion.artist
    }
    
  
    
   
}
