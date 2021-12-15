//
//  TrackTableViewCell.swift
//  Naranja Music
//
//  Created by Agustin Chinchilla on 05/11/2021.
//

import UIKit

class TrackTableViewCell: UITableViewCell {

    var track:Track?
    var parent:ButtonOnCellDelegate?
    var viewModel : TrackViewCellModel?
    
    //Propiedades computadas
    var icono : UIImageView = {
        let imgTrack = UIImageView()
        imgTrack.image = UIImage(named: "audioTrack")
        imgTrack.backgroundColor = .white
        imgTrack.translatesAutoresizingMaskIntoConstraints = false
        return imgTrack
    }()
    
    var titulo : UILabel = {
        let lbl = UILabel()
        lbl.text = "Titulo de la cancion"
        lbl.font = UIFont.systemFont(ofSize: 20)
        lbl.textColor = .white
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    var artista : UILabel  = {
        let lbl = UILabel()
        lbl.text = "Artista"
        lbl.textAlignment = .left
        lbl.font = UIFont.systemFont(ofSize: 12)
        lbl.textColor = UIColor(named: "subTitle")
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    var btnPlay : ButtonUIButton = {
        let botonUno = ButtonUIButton()
        botonUno.icon = UIImage(named: "PlayBtn")
        botonUno.secondIcon = UIImage(named: "StopBtn")
        botonUno.tintColor = .black
        botonUno.backgroundColor = .white
        botonUno.translatesAutoresizingMaskIntoConstraints = false
        botonUno.performTwoStateSelection()
        return botonUno
    }()
    
    var menuItems: [UIAction] {
        return [
            
          
            UIAction(title: "Play", image: UIImage(systemName: "play.fill"), handler: { (_) in
                self.viewModel?.trackViewDelegate?.actionButton(self)
                self.btnPlay.performTwoStateSelection()
            }),
            UIAction(title: "Download", image: UIImage(systemName: "tray.and.arrow.down.fill"), handler: { (_) in
                self.parent?.textAlert("Descargando")
                DownloadManager.shared.startDownload(URL(string: "https://speed.hetzner.de/100MB.bin")!)

            }),
            UIAction(title: "Eliminar de la playlist", image: UIImage(systemName: "trash"), attributes: .destructive, handler: { (_) in
                self.parent?.textAlert("Elimando")
            }),
        ]
    }
    var demoMenu: UIMenu {
        return UIMenu(title: "", image: nil, identifier: nil, options: [], children: menuItems)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
   
        viewModel = TrackViewCellModel()
        viewModel?.trackViewDelegate = self
       
       addSubview(icono)
        NSLayoutConstraint.activate([
            icono.topAnchor.constraint(equalTo: topAnchor, constant: 5),
            icono.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -5),
            icono.leadingAnchor.constraint(equalTo: leadingAnchor, constant:25),
            icono.widthAnchor.constraint(equalTo: icono.heightAnchor)
        
        ])
      addSubview(btnPlay)
        NSLayoutConstraint.activate([
            btnPlay.topAnchor.constraint(equalTo: topAnchor, constant: 5),
            btnPlay.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -5),
            btnPlay.trailingAnchor.constraint(equalTo: trailingAnchor, constant:-25),
            btnPlay.widthAnchor.constraint(equalTo: btnPlay.heightAnchor),

        ])
      
        

         addSubview(titulo)
         NSLayoutConstraint.activate([
            titulo.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            titulo.heightAnchor.constraint(equalToConstant: 35),
            titulo.leadingAnchor.constraint(equalTo: icono.trailingAnchor, constant: 5),
            titulo.trailingAnchor.constraint(equalTo: btnPlay.leadingAnchor, constant: -5)
            
         ])
      
         addSubview(artista)
         NSLayoutConstraint.activate([
            artista.heightAnchor.constraint(equalToConstant: 35),
            artista.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10),
            artista.leadingAnchor.constraint(equalTo: icono.trailingAnchor, constant: 5),
            artista.trailingAnchor.constraint(equalTo: btnPlay.leadingAnchor, constant: -5)

         ])
        
        contentView.isUserInteractionEnabled = false
        btnPlay.addTarget(self, action: #selector(handleAction), for: .touchUpInside)
        
      
    }
    
    func setCancion (_ cancion: Track) {
        viewModel?.trackViewDelegate?.changeTextLabel(cancion)
    }
    
    @objc func handleAction(_ btn: ButtonUIButton){
       
        if #available(iOS 14.0, *) {
            btn.menu = demoMenu
            btn.showsMenuAsPrimaryAction = true
         
       } else {
           viewModel?.trackViewDelegate?.actionButton(self)
           btnPlay.performTwoStateSelection()
       }
        
    }
        
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

