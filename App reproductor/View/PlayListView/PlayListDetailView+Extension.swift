//
//  PlayListDetailView+Extension.swift
//  Naranja Music
//
//  Created by Agustin Chinchilla on 04/12/2021.
//

import Foundation

extension PlayListDetailController : ReloadDataDelegate , BtnStatus , ShowViewDelegate {

    func refreshTable() {
        print(songsArray)
        listSongs.reloadData()

    }
    
    func audioPlayerDismissing() {
        if let index = listSongs.indexPathForSelectedRow {
            let cell = listSongs.cellForRow(at: index) as! TrackTableViewCell
            listSongs.deselectRow(at: index, animated: true)
            cell.btnPlay.performTwoStateSelection()
        }
    }
    
    func showAlert(_ message: String) {}

    func reloadDataTable() {
            listSongs.reloadData()
   }
    
    
    func changeView(_ celda: UITableViewCell) {
        let apvc = AudioPlayerViewController()

        if let index = listSongs.indexPath(for: celda){
            listSongs.selectRow(at: index, animated: false, scrollPosition: .none)
            let elTrack = songsArray[index.row]
            apvc.infoSong = elTrack
            apvc.delegate = self
        }
        
        self.present(apvc, animated: true , completion: nil)
    }
    
    
    func showView() {
        btnStatus = !btnStatus
        viewSongs.trackDelegate = self
        btnStatus ? self.view.addSubview(viewSongs) : viewSongs.removeFromSuperview()
    }
    
   func reloadTableView() {
     listSongs.reloadData()
   }
    
    func searchSongBar(_ textField: UITextField){
        if(textField.text != ""){
            let copiaArray =  songsArray.map{$0}
            let search = textField.text!.lowercased()
            let filteredArr = copiaArray.filter({$0.title.lowercased().contains(search)})
            songsArray = filteredArr
        }else{
            songsArray = Array(songs)
        }
        viewModel?.reloadDataDelegate?.reloadDataTable()
    }
       
    
}
