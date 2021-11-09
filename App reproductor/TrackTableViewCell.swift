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
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        

    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        //Definimos obj
        let imgTrack = UIImageView()
//        imgTrack.autoresizingMask = .flexibleWidth
        imgTrack.translatesAutoresizingMaskIntoConstraints = true
        imgTrack.frame = CGRect(x: 20, y: 10, width:60, height:60)
        imgTrack.image = UIImage(named: "audioTrack")
        imgTrack.backgroundColor = .white
        self.contentView.addSubview(imgTrack)
        self.imageView?.contentMode = UIView.ContentMode.scaleToFill
        
        let labelUno = UILabel()
        labelUno.text = "Titulo de la cancion"
        labelUno.font = UIFont.systemFont(ofSize: 20)
        labelUno.textColor = .white
        labelUno.autoresizingMask = .flexibleWidth
        labelUno.frame = CGRect(x: 105, y: 10, width: self.contentView.frame.width, height: 50)
        labelUno.textAlignment = .left
        labelUno.translatesAutoresizingMaskIntoConstraints = true
        self.contentView.addSubview(labelUno)
        
        let labelDos = UILabel()
        labelDos.text = "Artista"
        labelDos.textAlignment = .left
        labelDos.font = UIFont.systemFont(ofSize: 12)
        labelDos.textColor = UIColor(named: "subTitle")
        labelDos.autoresizingMask = .flexibleWidth
        labelDos.frame = CGRect(x: 105, y: 30, width: self.contentView.frame.width, height: 50)
        labelDos.translatesAutoresizingMaskIntoConstraints = true
        self.contentView.addSubview(labelDos)
        
        let botonUno = UIButton(type: .system)
        botonUno.frame = CGRect(x: 350, y: 20, width:50, height: 50)
        botonUno.setImage(UIImage(named: "PlayBtn"), for: .normal)
        botonUno.contentEdgeInsets = UIEdgeInsets(top:10,left:10,bottom:10,right:10)
        botonUno.layer.cornerRadius = 0.5 * botonUno.bounds.size.width
        botonUno.tintColor = .black
        botonUno.contentHorizontalAlignment = UIControl.ContentHorizontalAlignment.right
        botonUno.translatesAutoresizingMaskIntoConstraints = true
        botonUno.backgroundColor = .white
        self.contentView.addSubview(botonUno)
        botonUno.addTarget(self, action: #selector(handleAction), for: .touchUpInside)
    }
    @objc func handleAction(){
        guard let parent = parent else { return }
        parent.buttonTouchedOnCell(celda: self)
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
