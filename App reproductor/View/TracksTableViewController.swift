//
//  TracksTableViewController.swift
//  Naranja Music
//
//  Created by Agustin Chinchilla on 03/11/2021.
//

import UIKit

class TracksTableViewController: UITableViewController  {
   
    var viewModel : TracksTableModel?
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = TracksTableModel()
        viewModel?.reloadDataDelegate = self
        self.tableView.backgroundColor = .black
        self.tableView.register(TrackTableViewCell.self, forCellReuseIdentifier: "reuseIdentifier")
        self.tableView.rowHeight = 80.0
        tableView.delegate = viewModel!
        tableView.dataSource = viewModel!
    
    }
    
    
    override func viewWillAppear(_ animated: Bool) {

            viewModel?.callToApi()

    }

}

extension TracksTableViewController : ReloadDataDelegate {
        func reloadDataTable() {
            self.tableView.reloadData()
        }
    func changeView(_ celda: UITableViewCell) {
        
        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "Player") as? AudioPlayerViewController
        guard let vc = vc else {return}
        vc.modalPresentationStyle = .fullScreen
        guard let indexPath = self.tableView.indexPath(for: celda)else {return}
        let info = misTracks[indexPath.row]
        print("ejecuto aca papi")
        vc.infoSong = info
          self.present(vc, animated: true)
    }
    
}

