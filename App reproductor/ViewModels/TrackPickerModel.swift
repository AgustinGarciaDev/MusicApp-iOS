//
//  TrackPikerModel.swift
//  Naranja Music
//
//  Created by Agustin Chinchilla on 30/11/2021.
//

import Foundation

protocol TracksPickerDelegateView {
    func removeView()
}

class TrackPickerModel : NSObject{
    
    var  viewTrackDelegate : TracksPickerDelegateView?
}

extension TrackPickerModel : UIPickerViewDataSource{
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        misTracks.count
    }
}

extension TrackPickerModel : UIPickerViewDelegate {
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return misTracks[row].title
    }
}


