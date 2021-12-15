//
//  AudioPlayerViewController.swift
//  Naranja Music
//
//  Created by Agustin Chinchilla on 05/11/2021.
//

import UIKit
import AudioPlayer

class AudioPlayerViewController: UIViewController  {
    

    var isPlaying : Bool = true
    var mySound : AudioPlayer?
    var infoSong:Track?
    var slider = UISlider()
    var labelTres = UILabel()
    var timer = Timer()
    var labelUno = UILabel()
    var viewModel : AudioPlayerModel?
    var delegate : BtnStatus?
    var miButton = UIButton()
    var like : String = "Love"
    var likeView = LikeViewController()
   
    override func viewWillAppear(_ animated: Bool) {
        viewModel?.audioPlayerDelegate?.setData(infoSong!)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel = AudioPlayerModel()
        viewModel?.audioPlayerDelegate = self
        viewModel?.audioPlayerDelegate?.audioPlayer()
        
        self.view.backgroundColor = .white
        
        
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
        labelUno.font = UIFont.systemFont(ofSize: 23)
        labelUno.autoresizingMask = .flexibleWidth
        labelUno.frame = CGRect(x: 40, y: 300, width: self.view.frame.width, height: 50)
        labelUno.translatesAutoresizingMaskIntoConstraints = true
        labelUno.textAlignment = .left
        self.view.addSubview(labelUno)
        
        miButton.setImage(UIImage(systemName: "ellipsis.circle", withConfiguration: configurationIcon), for: .normal)
        miButton.translatesAutoresizingMaskIntoConstraints = true
        miButton.frame = CGRect(x: 330, y: 310, width: 30, height: 30)
        self.view.addSubview(miButton)
        miButton.addTarget(self, action: #selector(viewMenu) , for: .touchUpInside)

        
        labelTres.text = "Artista"
        labelTres.font = UIFont.systemFont(ofSize: 20)
        labelTres.autoresizingMask = .flexibleWidth
        labelTres.frame = CGRect(x: 40, y: 340, width: self.view.frame.width, height: 50)
        labelTres.translatesAutoresizingMaskIntoConstraints = true
        labelUno.textAlignment = .left
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
        slider.frame = CGRect(x: 20, y: 410, width: self.view.frame.width-100, height: 10)
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
        viewModel?.audioPlayerDelegate?.play()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        viewModel?.audioPlayerDelegate?.stop()
        delegate?.audioPlayerDismissing()
    }
    
    @objc func viewMenu(_ sender : UIButton){ 
        viewModel?.audioPlayerDelegate?.showMenu(sender)
    }
    @objc func controlRepro(){
        viewModel?.audioPlayerDelegate?.playerControl()
    }
    
    @objc func changeIcon(_ sender:ButtonUIButton) {
        viewModel?.audioPlayerDelegate?.iconStopAndPlay(sender)
    }
    
    @objc func close(){
        viewModel?.audioPlayerDelegate?.closeAudioPlayer()
    }

   @objc func update() {
    
       viewModel?.audioPlayerDelegate?.updateSlider()

   }
    
    @objc func volumen(sender: UISlider){
        viewModel?.audioPlayerDelegate?.volumenPlayer(sender)
    }
    @objc func timeSound(_ sender:UISlider){
        viewModel?.audioPlayerDelegate?.songTime(sender)
    }
    
 
    override func motionBegan(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
        viewModel?.audioPlayerDelegate?.motinEfect()
    }
}


