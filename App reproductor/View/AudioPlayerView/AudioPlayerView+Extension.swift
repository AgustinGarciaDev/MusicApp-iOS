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
        guard let getUrl =  Bundle.main.url(forResource: "fuego", withExtension: ".mp3") else {
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
    
