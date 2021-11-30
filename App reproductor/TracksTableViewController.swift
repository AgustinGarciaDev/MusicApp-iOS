//
//  TracksTableViewController.swift
//  Naranja Music
//
//  Created by Agustin Chinchilla on 03/11/2021.
//

import UIKit

class TracksTableViewController: UITableViewController , ButtonOnCellDelegate {
   
    func buttonTouchedOnCell(celda: UITableViewCell) {
        
        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "Player") as? AudioPlayerViewController
        guard let vc = vc else {return}
        vc.modalPresentationStyle = .fullScreen
        guard let indexPath = self.tableView.indexPath(for: celda)else {return}
        let info = misTracks[indexPath.row]
        vc.infoSong = info
          self.present(vc, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.backgroundColor = .black
        // Le indicamos al table view de que tipo van a ser las celdas que va a mostrar
        self.tableView.register(TrackTableViewCell.self, forCellReuseIdentifier: "reuseIdentifier")
        self.tableView.rowHeight = 80.0
    
    }
    
    override func viewWillAppear(_ animated: Bool) {
        let callBack: ([Track]?, Error?) -> () = { canciones , error in
            
            if error != nil  {
                print("Error")
            }else{
                misTracks = canciones ?? []
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }
        }
        
        let api = APIManager()
        api.getMusic(completion: callBack)
        
    }
    

    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return misTracks.count
    }
    
    

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       
        //2. Le pedimos al table view una celda y hacemos el CAST al tipo de clase que se registro en el paso 1
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath) as! TrackTableViewCell

        // Configure the cell...
        let elTrack = misTracks[indexPath.row]
        cell.setCancion(elTrack)
        cell.track = elTrack
        cell.parent = self
        cell.backgroundColor = .black
        cell.textLabel?.textColor = .white
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didEndDisplaying cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath) as! TrackTableViewCell
        cell.btnPlay.performTwoStateSelection()
    }

}
