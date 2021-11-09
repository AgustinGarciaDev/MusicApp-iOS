//
//  AudioPlayerViewController.swift
//  Naranja Music
//
//  Created by Agustin Chinchilla on 05/11/2021.
//

import UIKit

class AudioPlayerViewController: UIViewController {

    var isPlaying : Bool = false
    override func viewDidLoad() {
        super.viewDidLoad()

        let labelUno = UILabel()
        labelUno.text = "AudioPlayer"
        labelUno.font = UIFont.systemFont(ofSize: 30)
        labelUno.backgroundColor = UIColor(red: 0.0, green: 10, blue: 30, alpha: 1.0)
        labelUno.autoresizingMask = .flexibleWidth
        labelUno.frame = CGRect(x: 2, y: 50, width: self.view.frame.width, height: 50)
        labelUno.translatesAutoresizingMaskIntoConstraints = true
        labelUno.textAlignment = .center
        self.view.addSubview(labelUno)
        
        let botonUno = UIButton(type: .system)
        botonUno.setTitle("Play", for: .normal)
        botonUno.frame = CGRect(x: -150, y: 100, width: self.view.frame.width, height: 50)
        botonUno.translatesAutoresizingMaskIntoConstraints = true
        self.view.addSubview(botonUno)
        
        
        let botonDos = UIButton(type: .system)
        botonDos.setTitle("Stop", for: .normal)
        botonDos.frame = CGRect(x: 100, y: 100, width: self.view.frame.width, height: 50)
        botonDos.translatesAutoresizingMaskIntoConstraints = true
        self.view.addSubview(botonDos)
        
        let slider = UISlider()
        slider.autoresizingMask = .flexibleWidth
        slider.translatesAutoresizingMaskIntoConstraints = true
        slider.frame = CGRect(x: 30, y: 150, width: self.view.frame.width-100, height: 10)
        self.view.addSubview(slider)

        
        let labelDos = UILabel()
        labelDos.text = "Volumen"
        labelDos.font = UIFont.systemFont(ofSize: 20)
        labelDos.autoresizingMask = .flexibleWidth
        labelDos.frame = CGRect(x: 30, y: 170, width: self.view.frame.width, height: 50)
        labelDos.translatesAutoresizingMaskIntoConstraints = true
        labelDos.textAlignment = .left
        self.view.addSubview(labelDos)
        
        let sliderDos = UISlider()
        sliderDos.autoresizingMask = .flexibleWidth
        sliderDos.translatesAutoresizingMaskIntoConstraints = true
        sliderDos.frame = CGRect(x: 30, y: 200, width: self.view.frame.width-200, height: 50)
        sliderDos.tintColor = .orange
        self.view.addSubview(sliderDos)

        
    }
    
    override func motionBegan(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
        isPlaying = !isPlaying
        
        if isPlaying == true{
            print("Se esta reproduciendo")
        }else {
            print("No se esta reproduciendo")
        }
        
    }
    

}
