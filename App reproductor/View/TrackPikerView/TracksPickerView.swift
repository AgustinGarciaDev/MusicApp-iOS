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

class TracksPickerView: UIView{

    var trackDelegate : TracksPickerDelegate?
    var viewModel: TracksTableModel?
    var viewModelPicker : TrackPickerModel?
    var btnClose: UIButton = {
        let btn = UIButton()
        let configurationIcon = UIImage.SymbolConfiguration(
            pointSize: 28, weight: .medium, scale: .default)
        btn.setImage(UIImage(systemName: "x.circle", withConfiguration: configurationIcon), for: .normal)
        btn.translatesAutoresizingMaskIntoConstraints = false

        return btn
    }()
    
    var btnAdd : UIButton = {
        let btn = UIButton()
        let configurationIcon = UIImage.SymbolConfiguration(
            pointSize: 28, weight: .medium, scale: .default)
        btn.setImage(UIImage(systemName: "plus", withConfiguration: configurationIcon), for: .normal)
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
       self.frame = CGRect(x: 0, y: 390, width: 800, height: 300)
       

       btnClose.addTarget(self, action: #selector(close), for: .touchUpInside)
       self.addSubview(btnClose)
       NSLayoutConstraint.activate([
        btnClose.topAnchor.constraint(equalTo: self.topAnchor , constant: 10),
        btnClose.leadingAnchor.constraint(equalTo: self.leadingAnchor , constant: 30),
        btnClose.widthAnchor.constraint(equalToConstant: 50),
        btnClose.heightAnchor.constraint(equalToConstant: 50),
       ])
       
       
       btnAdd.addTarget(self, action: #selector(addSong), for: .touchUpInside)
       self.addSubview(btnAdd)
              NSLayoutConstraint.activate([
               btnAdd.topAnchor.constraint(equalTo: self.topAnchor , constant: 10),
               btnAdd.widthAnchor.constraint(equalToConstant: 50),
               btnAdd.heightAnchor.constraint(equalToConstant: 50),
               btnAdd.trailingAnchor.constraint(equalTo: btnClose.trailingAnchor , constant: 300)
        ])

       
       self.addSubview(pickerList)
       NSLayoutConstraint.activate([
        pickerList.topAnchor.constraint(equalTo: btnClose.bottomAnchor, constant: 5),
        pickerList.widthAnchor.constraint(equalToConstant: 412),
        pickerList.heightAnchor.constraint(equalToConstant: 200)

       ])
       viewModelPicker = TrackPickerModel()
       viewModelPicker?.viewTrackDelegate = self
       viewModel = TracksTableModel()
       viewModel?.reloadDataDelegate = self
       viewModel?.callToApi()
       
       pickerList.dataSource = viewModelPicker!
       pickerList.delegate = viewModelPicker!
       
     

       
   }
    
    @objc func addSong(){
        if trackDelegate != nil {
            let selectedRow = self.pickerList.selectedRow(inComponent: 0)
            let value = misTracks[selectedRow]
           trackDelegate?.addTrack(song: value)
        }
    }
    @objc func close(){
        viewModelPicker?.viewTrackDelegate?.removeView()
    }
    
    required init?(coder aDecoder: NSCoder) {
       super.init(coder: aDecoder)
        
    }

}



extension TracksPickerView : ReloadDataDelegate{
    func changeView(_ celda: UITableViewCell) {
       }
    
    func reloadDataTable() {
        pickerList.reloadAllComponents()
    }
   
}

extension TracksPickerView: TracksPickerDelegateView{
    func removeView() {
        self.removeFromSuperview()
    }
}
