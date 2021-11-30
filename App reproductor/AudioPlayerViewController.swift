//
//  AudioPlayerViewController.swift
//  Naranja Music
//
//  Created by Agustin Chinchilla on 05/11/2021.
//

import UIKit
import AudioPlayer

class AudioPlayerViewController: UIViewController {

    var isPlaying : Bool = true
    var mySound : AudioPlayer?
    var infoSong:Track?
    var slider = UISlider()
    var labelTres = UILabel()
    var timer = Timer()
    var labelUno = UILabel()

    
    
    override func viewWillAppear(_ animated: Bool) {
        if let title = infoSong?.title {
            self.labelUno.text = title
        }
        
        if let artist = infoSong?.artist{
            self.labelTres.text = artist
        }
         
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let getUrl =  Bundle.main.url(forResource: "fuego", withExtension: ".mp3") else {
            return
        }
        
        do{
            mySound = try AudioPlayer(contentsOf: getUrl)
            timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector:#selector(update), userInfo: nil, repeats: true)
           
        }catch{
            print("Ocurrio un error inesperado")
        }
        
        let btnClose = UIButton()
        let configurationIcon = UIImage.SymbolConfiguration(
            pointSize: 32, weight: .medium, scale: .default)
        btnClose.setImage(UIImage(systemName: "xmark", withConfiguration: configurationIcon), for: .normal)
        btnClose.frame = CGRect(x: 10, y: 40, width: 80, height: 80)
        btnClose.tintColor = .black
        btnClose.translatesAutoresizingMaskIntoConstraints = true
        self.view.addSubview(btnClose)
        btnClose.addTarget(self, action: #selector(close), for: .touchUpInside)
        
        if let laURL = Bundle.main.url(forResource: "sound", withExtension: ".gif") {
            let elGIF = UIImage.animatedImage(withAnimatedGIFURL: laURL)
            let imgContainer = UIImageView(image: elGIF)
            imgContainer.translatesAutoresizingMaskIntoConstraints=true
            imgContainer.frame=CGRect(x: 0, y: 100, width: 200, height: 200)
            imgContainer.center.x = self.view.center.x
            self.view.addSubview(imgContainer)
        }

        labelUno.text = "AudioPlayer"
        labelUno.font = UIFont.systemFont(ofSize: 26)
        labelUno.autoresizingMask = .flexibleWidth
        labelUno.frame = CGRect(x: 2, y: 300, width: self.view.frame.width, height: 50)
        labelUno.translatesAutoresizingMaskIntoConstraints = true
        labelUno.textAlignment = .center
        self.view.addSubview(labelUno)
        
        labelTres.text = "Artista"
        labelTres.font = UIFont.systemFont(ofSize: 20)
        labelTres.autoresizingMask = .flexibleWidth
        labelTres.frame = CGRect(x: 2, y: 340, width: self.view.frame.width, height: 50)
        labelTres.translatesAutoresizingMaskIntoConstraints = true
        labelTres.textAlignment = .center
        self.view.addSubview(labelTres)
        
        
        
        let botonUno = ButtonUIButton()
        botonUno.icon = UIImage(named: "StopBtn")
        botonUno.secondIcon = UIImage(named: "PlayBtn")
        botonUno.frame = CGRect(x: 30, y: 440, width: 80, height: 80)
        botonUno.translatesAutoresizingMaskIntoConstraints = true
        botonUno.performTwoStateSelection()
        botonUno.backgroundColor = .orange
        botonUno.tintColor = .white
        botonUno.center.x = self.view.center.x
        self.view.addSubview(botonUno)
        botonUno.addTarget(self, action: #selector(controlRepro), for: .touchUpInside)
        botonUno.addTarget(self, action: #selector(changeIcon), for: .touchUpInside)
        
        
        
        slider.autoresizingMask = .flexibleWidth
        slider.translatesAutoresizingMaskIntoConstraints = true
        slider.frame = CGRect(x: 30, y: 410, width: self.view.frame.width-100, height: 10)
        guard let duration = mySound?.duration else {return}
        slider.maximumValue = Float(duration)
        slider.center.x = self.view.center.x
        self.view.addSubview(slider)
        slider.addTarget(self, action: #selector(timeSound), for: .touchUpInside)

        
        let labelDos = UILabel()
        labelDos.text = "Volumen"
        labelDos.textAlignment  = .center
        labelDos.font = UIFont.systemFont(ofSize: 20)
        labelDos.autoresizingMask = .flexibleWidth
        labelDos.frame = CGRect(x: 0, y: 530, width: self.view.frame.width, height: 50)
        labelDos.translatesAutoresizingMaskIntoConstraints = true
        labelDos.center.x = self.view.center.x
        self.view.addSubview(labelDos)
        
        
        let sliderDos = UISlider()
        sliderDos.autoresizingMask = .flexibleWidth
        sliderDos.translatesAutoresizingMaskIntoConstraints = true
        sliderDos.frame = CGRect(x: 30, y: 580, width: self.view.frame.width-200, height: 50)
        sliderDos.tintColor = .orange
        sliderDos.value = 1.0
        sliderDos.center.x = self.view.center.x

        self.view.addSubview(sliderDos)
        sliderDos.addTarget(self, action: #selector(volumen), for: .valueChanged)

       
    }
 
    
    
    override func viewDidAppear(_ animated: Bool) {

        mySound?.play()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
       mySound?.stop()
        
    }
    
    @objc func controlRepro(){
        isPlaying = !isPlaying
        
        if isPlaying == true{
            mySound?.play()
            timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector:#selector(update), userInfo: nil, repeats: true)
        }else {
            mySound?.stop()
        }
    }
    
    @objc func changeIcon(_ sender:ButtonUIButton) {
        sender.performTwoStateSelection()
    }
    
    @objc func close(){
        dismiss(animated: true)
    }
    
    
    
//   @objc func playSound(){
//    mySound?.play()
//    timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector:#selector(update), userInfo: nil, repeats: true)
//    }
    
   @objc func update() {
       guard let tiempo = mySound?.currentTime else {return }
       slider.value = Float(tiempo)

   }
    
//   @objc func stopSound(){
//       mySound?.stop()
//       timer.invalidate()
//   }
    
    @objc func volumen(sender: UISlider){
        mySound?.volume = sender.value
        
    }
    @objc func timeSound(sender:UISlider){
        mySound?.stop()
        mySound?.currentTime = TimeInterval(sender.value)
        mySound?.play()
    }
    
 
    override func motionBegan(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
        isPlaying = !isPlaying
        
        if isPlaying == true{
            mySound?.play()
        }else {
            mySound?.stop()
        }
        
    }
    

}
