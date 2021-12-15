//
//  TrackPickerView+Extension.swift
//  Naranja Music
//
//  Created by Agustin Chinchilla on 04/12/2021.
//

import Foundation

extension TracksPickerView : ReloadDataDelegate{
    func showAlert(_ message: String) {
        //
    }
    
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
