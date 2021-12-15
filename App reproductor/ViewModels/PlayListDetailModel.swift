//
//  PlayListDetailModel.swift
//  Naranja Music
//
//  Created by Agustin Chinchilla on 30/11/2021.
//

import Foundation

protocol ShowViewDelegate {
    func showView()
    func reloadTableView()
    func searchSongBar(_ textField: UITextField)
}

protocol AddSongTable {
    func addSongTable(_ song: Track)
}

class PlayListDetailModel : NSObject {
    var reloadDataDelegate : ReloadDataDelegate?
    var showViewDelegate : ShowViewDelegate?
    
}
extension PlayListDetailModel : AddSongTable {
    func addSongTable(_ song: Track) {
       songs.insert(song)
       songsArray = Array(songs)
       showViewDelegate?.reloadTableView()
    }

}


extension PlayListDetailModel :  UITableViewDataSource ,  UITableViewDelegate  {
    

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return songsArray.count
      }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath) as! TrackTableViewCell
        let elTrack = songsArray[indexPath.row]
        cell.setCancion(elTrack)
        cell.track = elTrack
        cell.parent = self
        cell.backgroundColor = .black
        cell.textLabel?.textColor = .white
        return cell
    }
   func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            songs = songs.filter{ $0.song_id != songsArray[indexPath.row].song_id}
            songsArray.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            tableView.reloadData()
        }
       
     
    }
    
    
}

extension PlayListDetailModel : ButtonOnCellDelegate {
    func textAlert(_ message: String) {
        
    }
    
    func buttonTouchedOnCell(celda: UITableViewCell) {
        reloadDataDelegate?.changeView(celda)
    }
}
