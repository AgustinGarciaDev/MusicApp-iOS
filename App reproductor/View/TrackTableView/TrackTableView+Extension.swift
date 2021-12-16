//
//  TrackTableView+Extension.swift
//  Naranja Music
//
//  Created by Agustin Chinchilla on 04/12/2021.
//

import Foundation
extension TracksTableViewController : ReloadDataDelegate , BtnStatus {
  
    
    func refreshTable() {
        viewModel?.reloadDataDelegate?.reloadDataTable()
    }
    
    func audioPlayerDismissing() {
        if let index = tableView.indexPathForSelectedRow {
            let cell = tableView.cellForRow(at: index) as! TrackTableViewCell
            tableView.deselectRow(at: index, animated: true)
            cell.btnPlay.performTwoStateSelection()
        }
    }
    
    func showAlert(_ message: String) {
        self.alertModal(message)
    }
    
    func reloadDataTable() {
        self.tableView.reloadData()
    }
    func changeView(_ celda: UITableViewCell) {
            let apvc = AudioPlayerViewController()

            if let index = tableView.indexPath(for: celda){
                tableView.selectRow(at: index, animated: false, scrollPosition: .none)
                let elTrack = misTracks[index.row]
                apvc.infoSong = elTrack
                apvc.delegate = self
            }
            self.present(apvc, animated: true , completion: nil)
    }
       
}

