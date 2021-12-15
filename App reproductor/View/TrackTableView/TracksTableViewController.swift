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
    private var observer: Any!
    var timer: Timer? = nil


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
        
        observer =  NotificationCenter.default.addObserver(self, selector: #selector(updateTable), name: NSNotification.Name("updateTable"), object: nil)
       timer = Timer.scheduledTimer(withTimeInterval: 20, repeats: true){ timer in
            
        NotificationCenter.default.post(name: NSNotification.Name("updateTable"), object: nil)
           
        }
      
    }
    
    @objc func updateTable(){
        print("update")
        viewModel?.reloadDataDelegate?.reloadDataTable()
      }
    
    
    override func viewWillAppear(_ animated: Bool) {
        viewModel?.reloadDataDelegate?.reloadDataTable()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        NotificationCenter.default.removeObserver(self.observer ?? "")
        self.timer!.invalidate()
        viewModel?.reloadDataDelegate?.reloadDataTable()
    }
    


}


