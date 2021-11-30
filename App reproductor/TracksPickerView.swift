//
//  TracksPickerView.swift
//  Naranja Music
//
//  Created by Agustin Chinchilla on 29/11/2021.
//

import UIKit

protocol TracksPickerDelegate {
    func addTrack(song:Track)
}

class TracksPickerView: UIView {

    var trackDelegate : TracksPickerDelegate?
    
    var btnClose: UIButton = {
        let btn = UIButton()
        btn.setImage(UIImage(systemName: "x.circle.fill"), for: .normal)
        btn.translatesAutoresizingMaskIntoConstraints = false

        return btn
    }()
    
    var btnAdd : UIButton = {
        let btn = UIButton()
        btn.setImage(UIImage(systemName: "plus"), for: .normal)
        btn.translatesAutoresizingMaskIntoConstraints = false

        return btn
    }()
    
    var pickerList : UIPickerView = {
        let picker = UIPickerView()
        picker.translatesAutoresizingMaskIntoConstraints = false
        return picker
    }()

   override init (frame : CGRect) {
    super.init(frame : frame)
       

       
       self.backgroundColor = .orange
       self.frame = CGRect(x: 0, y: 500, width: 800, height: 500)
       

       btnClose.addTarget(self, action: #selector(close), for: .touchUpInside)
       self.addSubview(btnClose)
       NSLayoutConstraint.activate([
        btnClose.topAnchor.constraint(equalTo: self.topAnchor , constant: 20),
        btnClose.widthAnchor.constraint(equalToConstant: 50),
        btnClose.heightAnchor.constraint(equalToConstant: 50),
       ])
       
       
       btnAdd.addTarget(self, action: #selector(addSong), for: .touchUpInside)
       self.addSubview(btnAdd)
              NSLayoutConstraint.activate([
               btnAdd.topAnchor.constraint(equalTo: self.topAnchor , constant: 20),
               btnAdd.widthAnchor.constraint(equalToConstant: 50),
               btnAdd.heightAnchor.constraint(equalToConstant: 50),
               btnAdd.trailingAnchor.constraint(equalTo: btnClose.trailingAnchor , constant: 350)
        ])

       
       
     
       
       self.addSubview(pickerList)
       NSLayoutConstraint.activate([
        pickerList.topAnchor.constraint(equalTo: self.topAnchor, constant: 50),
       
        pickerList.widthAnchor.constraint(equalToConstant: 412)

       ])
       pickerList.dataSource = self
       pickerList.delegate = self
       
       
       
       let callBack: ([Track]?, Error?) -> () = { canciones , error in
           
           if error != nil  {
               print("Error")
           }else{
               misTracks = canciones ?? []
               
           }
       }
       
       let api = APIManager()
       api.getMusic(completion: callBack)
       print(misTracks)
   }
    
    @objc func addSong(){
        if trackDelegate != nil {
            print("entro")
            let selectedRow = self.pickerList.selectedRow(inComponent: 0)
            let value = misTracks[selectedRow]
            print(value)
           trackDelegate?.addTrack(song: value)
        }
    }
    @objc func close(){
        self.removeFromSuperview()
    }
    
    required init?(coder aDecoder: NSCoder) {
       super.init(coder: aDecoder)
        
    }

}


extension TracksPickerView : UIPickerViewDataSource{
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        misTracks.count
    }
}

extension TracksPickerView : UIPickerViewDelegate {
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        return misTracks[row].title

    }
   
}
