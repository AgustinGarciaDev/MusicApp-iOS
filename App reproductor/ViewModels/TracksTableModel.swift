//
//  TracksTableModel.swift
//  Naranja Music
//
//  Created by Agustin Chinchilla on 30/11/2021.
//

import Foundation
import CoreData
import UIKit

protocol ReloadDataDelegate {
    func reloadDataTable()
    func changeView(_ celda: UITableViewCell)
    func showAlert(_ message:String)
}


class TracksTableModel : NSObject{
    
    var reloadDataDelegate : ReloadDataDelegate?

    func saveData(){
        guard let appDelegate  = UIApplication.shared.delegate as? AppDelegate else {return}
        let context = appDelegate.managedObjectContext
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Track_")
        
        do{
            let result = try context!.fetch(request)
            misTracks = [Track]()
            
            
            for item in result as! [NSManagedObject] {
                let title = item.value(forKey: "title") as? String
                let album = item.value(forKey: "album") as? String
                let song_id = item.value(forKey: "song_id") as? String
                let artist = item.value(forKey: "artist") as? String
                let genre = item.value(forKey: "genre") as? String
                
                let track = Track(song_id:song_id ?? "",
                                   title: title ?? "" ,
                                   artist: artist ?? "" ,
                                   genre: genre ?? "",
                                  album: album ?? "" ,
                                  downloading: false)
                misTracks.append(track)
            }
        
        }catch{
            print("Fallamos al obtener la informacion de la base de datos, \(error.localizedDescription)")
        }
        
        
        
    }
    
    func callToApi(){
        
        guard let appDelegate  = UIApplication.shared.delegate as? AppDelegate else {return}
        
        let context = appDelegate.managedObjectContext
        
        
        RestServiceManager.shared.GoToInfo(responseType:  SongsList.self, method: .get, endpoint: "/db.json"){status , data in
            if let response = data?.songs {
                //Usamos coreData
                if let _context = context {
                    //Eliminar contenido
                    let fetchRequest:NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: "Track_")
                    let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
                    
                    do {
                        try  appDelegate.persistentStoreCoordinator?.execute(deleteRequest, with: _context)
                    }catch{
                        print(error.localizedDescription)
                    }
                    
                    for item in response  {
                        guard let tracksEntity = NSEntityDescription.insertNewObject(forEntityName: "Track_", into: _context) as?  NSManagedObject else  {
                            return
                        }
                        tracksEntity.setValue(item.album, forKey: "album")
                        tracksEntity.setValue(item.song_id, forKey: "song_id")
                        tracksEntity.setValue(item.genre, forKey: "genre")
                        tracksEntity.setValue(item.title, forKey: "title")
                        tracksEntity.setValue(item.artist, forKey: "artist")
                        tracksEntity.setValue(item.downloading, forKey: "downloading")

                        do{
                            try _context.save()
                        }catch {
                            print("No se guardo la info \(error)")
                        }
                        
                    }
                }
            
                DispatchQueue.main.async {
                    self.reloadDataDelegate?.reloadDataTable()
                }
            }
        }
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
       
        cell.cellDownloading = indexPath.row
       
       if elTrack.downloading == true {
           cell.statusDownload.isHidden = false
       }else{
           cell.statusDownload.isHidden = true
       }
        return cell
    }
    
}

extension TracksTableModel : ButtonOnCellDelegate {
  
 
    func buttonTouchedOnCell(celda: UITableViewCell) {
        reloadDataDelegate?.changeView(celda)
    }
    func textAlert(_ message: String) {
        reloadDataDelegate?.showAlert(message)
    }
    
}
