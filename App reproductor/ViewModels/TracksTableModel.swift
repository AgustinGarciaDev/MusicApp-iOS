//
//  TracksTableModel.swift
//  Naranja Music
//
//  Created by Agustin Chinchilla on 30/11/2021.
//

import Foundation

protocol ReloadDataDelegate {
    func reloadDataTable()
    func changeView(_ celda: UITableViewCell)
  
}


class TracksTableModel : NSObject{
    
    var reloadDataDelegate : ReloadDataDelegate?
    
    func callToApi() {
        let callBack: ([Track]?, Error?) -> () = { canciones , error in
            
            if error != nil  {
                print("Error")
            }else{
                misTracks = canciones ?? []
               DispatchQueue.main.async {
                   self.reloadDataDelegate?.reloadDataTable()
               }
            }
        }
        
        let api = APIManager()
        api.getMusic(completion: callBack)
    }
}


extension TracksTableModel : UITableViewDelegate{
    
}

extension TracksTableModel : UITableViewDataSource{
     func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return misTracks.count
    }
    
    

    
   func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath) as! TrackTableViewCell

        let elTrack = misTracks[indexPath.row]
        cell.setCancion(elTrack)
        cell.track = elTrack
        cell.parent = self
        cell.backgroundColor = .black
        cell.textLabel?.textColor = .white
        return cell
    }
    
    func tableView(_ tableView: UITableView, didEndDisplaying cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath) as! TrackTableViewCell
        cell.btnPlay.performTwoStateSelection()
    }
    
    
}

extension TracksTableModel : ButtonOnCellDelegate {
    func buttonTouchedOnCell(celda: UITableViewCell) {
        reloadDataDelegate?.changeView(celda)
    }
}
