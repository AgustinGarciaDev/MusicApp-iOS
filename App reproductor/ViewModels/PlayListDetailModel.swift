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
}

protocol AddSongTable {
    func addSongTable(_ song: Track)
}

class PlayListDetailModel : NSObject {
    var reloadDataDelegate : ReloadDataDelegate?
    var songs = Set<Track>()
    var showViewDelegate : ShowViewDelegate?
    
}
extension PlayListDetailModel : AddSongTable {
    func addSongTable(_ song: Track) {
       songs.insert(song)
//        print(song)
       songsArray = Array(songs)
       showViewDelegate?.reloadTableView()
    }
    
    
}


extension  PlayListDetailModel:  UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didEndDisplaying cell: UITableViewCell, forRowAt indexPath: IndexPath) {        
       let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath) as! TrackTableViewCell
        
        cell.btnPlay.performTwoStateSelection()
    }
    
    
}

extension PlayListDetailModel :  UITableViewDataSource {
    

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return songsArray.count
      }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath) as! TrackTableViewCell
        let elTrack = songsArray[indexPath.row]
    //    print(elTrack)
        cell.setCancion(elTrack)
        cell.track = elTrack
        cell.parent = self
        cell.backgroundColor = .black
        cell.textLabel?.textColor = .white
        return cell
    }
  
    
    
}

extension PlayListDetailModel : ButtonOnCellDelegate {
    func buttonTouchedOnCell(celda: UITableViewCell) {
        print(celda)
        reloadDataDelegate?.changeView(celda)
    }
}
