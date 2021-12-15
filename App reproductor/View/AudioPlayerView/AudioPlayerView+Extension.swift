//
//  AudioPlayerView+Extension.swift
//  Naranja Music
//
//  Created by Agustin Chinchilla on 04/12/2021.
//

import Foundation
import UIKit
import AudioPlayer

extension  AudioPlayerViewController: AudioPlayerProtocol {
    func showMenu(_ sender: UIButton) {
        if #available(iOS 14.0, *) {
            sender.menu = viewModel?.audioPlayerDelegate?.menuButton()
            sender.showsMenuAsPrimaryAction = true
        } else {
            print("no hay menu")
        }
    }
    
    func menuButton() -> UIMenu{
        
        var menuItems: [UIAction] {
            return [
                UIAction(title: "Delete from library", image: UIImage(systemName: "trash"), attributes: .destructive, handler: { (_) in
                    btnMenuOptions.trash.borrarCancion(self.infoSong!)
                    self.dismiss(animated: true){
                        self.delegate?.refreshTable()
                        
                    }
                }),
                UIAction(title: "Add to a playlist", image: UIImage(systemName: "play.fill"), handler: { (_) in
                    btnMenuOptions.addPlaylist.agregarAplaylist(self.infoSong!)
                }),
                UIAction(title: "Share song", image: UIImage(systemName: "square.and.arrow.up.fill"), handler: { (_) in
                    btnMenuOptions.addPlaylist.compartirCancion()
                    let song = [self.infoSong!.artist ,  self.infoSong!.title ]
                    let ac = UIActivityViewController(activityItems: song as [Any], applicationActivities: nil)
                    ac.popoverPresentationController?.sourceView = self.view
                    self.present(ac, animated: true)

                }),
                UIAction(title: "download", image: UIImage(systemName: "tray.and.arrow.down.fill"), handler: { (_) in
                    btnMenuOptions.download.descargarCancion()
                    let message = "Estas por descargar \(self.infoSong!.title)"
                    self.alertModal(message)
                }),
                UIAction(title: like, image: UIImage(systemName: "heart.fill"), handler: { (_ sender) in
                    self.view.addSubview(self.likeView)
                    self.like = "Unlove"
                    btnMenuOptions.love.likearCancion()
                }),
            ]
        }
        
        
        var demoMenu: UIMenu {
            return UIMenu(title: "", image: nil, identifier: nil, options: [], children: menuItems)
        }
        
        return demoMenu
    }
    
    
    
    func volumenPlayer(_ sender: UISlider) {
        mySound?.volume = sender.value
    }
    
    func stop() {
        mySound?.stop()
    }
    
    func play() {
        mySound?.play()
    }
    
   
    func setData(_ song: Track) {

        self.labelUno.text = song.title
        self.labelTres.text = song.artist
    }
    
    func audioPlayer() {
        guard let getUrl = Bundle.main.url(forResource: "fuego", withExtension: ".mp3") else {
            return
        }
        
        do{
            mySound = try AudioPlayer(contentsOf: getUrl)
            timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector:#selector(update), userInfo: nil, repeats: true)
           
        }catch{
            print("Ocurrio un error inesperado")
        }
    }
    
    func motinEfect() {
        isPlaying = !isPlaying
        
        if isPlaying == true{
            mySound?.play()
        }else {
            mySound?.stop()
        }
    }
    
    func songTime(_ sender:UISlider){
        mySound?.stop()
        mySound?.currentTime = TimeInterval(sender.value)
        mySound?.play()
    }
    
    func playerControl() {
        isPlaying = !isPlaying
        
        if isPlaying == true{
            mySound?.play()
            timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector:#selector(update), userInfo: nil, repeats: true)
        }else {
            mySound?.stop()
        }
    }
    func updateSlider() {
        guard let tiempo = mySound?.currentTime else {return }
        slider.value = Float(tiempo)
    }
    
    func iconStopAndPlay(_ sender:ButtonUIButton) {
        sender.performTwoStateSelection()
    }
    
    func closeAudioPlayer() {
        dismiss(animated: true)
        
    }
    
}
    
