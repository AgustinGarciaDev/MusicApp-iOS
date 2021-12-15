//
//  AudioPlayerModel.swift
//  Naranja Music
//
//  Created by Agustin Chinchilla on 01/12/2021.
//

import Foundation
import AudioPlayer

protocol AudioPlayerProtocol {
    func setData (_ song:Track)
    func audioPlayer()
    func motinEfect()
    func songTime(_ sender:UISlider)
    func playerControl()
    func updateSlider()
    func iconStopAndPlay(_ sender:ButtonUIButton)
    func stop()
    func play()
    func volumenPlayer(_ sender:UISlider)
    func closeAudioPlayer()
    func menuButton() -> UIMenu
    func showMenu(_ sender : UIButton)

}

protocol BtnStatus {
    func audioPlayerDismissing()
    func refreshTable()
}



class AudioPlayerModel {
    var mySound : AudioPlayer?
    var infoSong:Track?
    var isPlaying : Bool = true
    var audioPlayerDelegate : AudioPlayerProtocol?
    var timer = Timer()
    
    
}


