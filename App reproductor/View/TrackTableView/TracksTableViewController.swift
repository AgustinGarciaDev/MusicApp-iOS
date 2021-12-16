//
//  TracksTableViewController.swift
//  Naranja Music
//
//  Created by Agustin Chinchilla on 03/11/2021.
//

import UIKit
import NotificationCenter

class TracksTableViewController: UITableViewController  {
   
    var viewModel : TracksTableModel?
    
    var celda : UITableViewCell?
   
    var progresStatus : Double = 0.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = TracksTableModel()
        viewModel?.reloadDataDelegate = self
        self.tableView.backgroundColor = .black
        self.tableView.register(TrackTableViewCell.self, forCellReuseIdentifier: "reuseIdentifier")
        self.tableView.rowHeight = 80.0
        tableView.delegate = viewModel!
        tableView.dataSource = viewModel!
        
        viewModel?.saveData()
        
        NotificationCenter.default.addObserver(self, selector: #selector(downloadStatus(_:)), name: NSNotification.Name("updateTable"), object: nil)
        
       
        
    }
    
    @objc func downloadStatus(_ notification: NSNotification){
      progresStatus = notification.object as! Double
       
        if let dict = notification.userInfo as NSDictionary? {
                 if let id = dict["celda"] as? TrackTableViewCell{
                    DispatchQueue.main.async {
                        if id.track?.downloading == true{
                            id.statusDownload.setProgress(Float(self.progresStatus), animated: true)
                        }
                      }
                     reloadCellDownload(progresStatus, id.cellDownloading!)
                 }
           
        }
    }
    
    func reloadCellDownload(_ dato:Double , _ indexPath:Int){
        let cellPosition = IndexPath(row:indexPath, section: 0)

        DispatchQueue.main.async {
            if let cell = self.tableView.cellForRow(at: cellPosition) as? TrackTableViewCell{
                if(dato == 1.0){
                    cell.statusDownload.isHidden = true
                }else{
                    cell.statusDownload.setProgress(Float(self.progresStatus), animated: true)
                }
            }
        }
    
    }

    override func viewWillAppear(_ animated: Bool) {
        viewModel?.reloadDataDelegate?.reloadDataTable()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        NotificationCenter.default.removeObserver("updateTable")
        viewModel?.reloadDataDelegate?.reloadDataTable()
    }
    


}


