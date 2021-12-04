//
//  PlayListDetailController.swift
//  Naranja Music
//
//  Created by Agustin Chinchilla on 29/11/2021.
//

import UIKit

class PlayListDetailController: UIViewController , TracksPickerDelegate , ShowViewDelegate {

    var viewSongs = TracksPickerView()
    var btnStatus = false
    var viewModel : PlayListDetailModel?
    
    var listSongs  : UITableView = {
        let table = UITableView()
        table.translatesAutoresizingMaskIntoConstraints = false
        return table
    }()
    
    func showView() {
        btnStatus = !btnStatus
        viewSongs.trackDelegate = self
        btnStatus ? self.view.addSubview(viewSongs) : viewSongs.removeFromSuperview()
    }
    
  func reloadTableView() {
            listSongs.reloadData()
   }
       


    var inputText : UITextField = {
        let label = UITextField()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.placeholder = "Playlist..."
        label.tintColor = .orange
        label.leftViewMode = UITextField.ViewMode.always
        label.backgroundColor = .orange
        label.sizeToFit()
        return label
    }()
    
    var btnAddSong : UIButton = {
        let btn = UIButton()
        let configurationIcon = UIImage.SymbolConfiguration(
            pointSize: 32, weight: .medium, scale: .default)
        btn.backgroundColor = .black
        btn.setImage(UIImage(systemName: "plus", withConfiguration: configurationIcon), for: .normal)
        btn.translatesAutoresizingMaskIntoConstraints = false

        return btn
    }()
    
 
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        viewModel = PlayListDetailModel()
        viewModel?.showViewDelegate = self
        viewModel?.reloadDataDelegate = self
        let safeA = self.view.safeAreaLayoutGuide
        self.view.addSubview(inputText)
        NSLayoutConstraint.activate([
            inputText.topAnchor.constraint(equalTo: safeA.topAnchor,constant: 5),
            inputText.leadingAnchor.constraint(equalTo: safeA.leadingAnchor , constant: 25),
            inputText.trailingAnchor.constraint(equalTo: safeA.trailingAnchor , constant:  -100),
            inputText.heightAnchor.constraint(equalToConstant: 55)
        ])
        
        self.view.addSubview(btnAddSong)
        NSLayoutConstraint.activate([
            btnAddSong.topAnchor.constraint(equalTo: safeA.topAnchor,constant: 5),
            btnAddSong.leadingAnchor.constraint(equalTo: safeA.trailingAnchor, constant: 15),
            btnAddSong.trailingAnchor.constraint(equalTo: safeA.trailingAnchor , constant:  -15),
            btnAddSong.widthAnchor.constraint(equalToConstant: 55),
            btnAddSong.heightAnchor.constraint(equalToConstant: 55)

        ])
        btnAddSong.addTarget(self, action: #selector(callSubView), for: .touchUpInside)
        
        
        listSongs.backgroundColor = .black
        self.view.addSubview(listSongs)
        NSLayoutConstraint.activate([
           listSongs.topAnchor.constraint(equalTo: inputText.bottomAnchor, constant: 10 ),
            listSongs.bottomAnchor.constraint(equalTo: safeA.bottomAnchor, constant: -5),
            listSongs.leadingAnchor.constraint(equalTo: safeA.leadingAnchor, constant: 0),
            listSongs.trailingAnchor.constraint(equalTo: safeA.trailingAnchor,constant: 0),
        ])
        listSongs.register(TrackTableViewCell.self, forCellReuseIdentifier: "reuseIdentifier")
        listSongs.delegate = viewModel!
        listSongs.dataSource = viewModel!
        listSongs.rowHeight = 80.0
        
    }
    
    @objc func callSubView(){
        viewModel?.showViewDelegate?.showView()
    }
    
    func addTrack(song: Track) {
        
        viewModel?.addSongTable(song)

    }
    
    override func viewWillDisappear(_ animated: Bool) {
        viewModel?.reloadDataDelegate?.reloadDataTable()
    }
    
    }

extension PlayListDetailController : ReloadDataDelegate {
        func reloadDataTable() {
            listSongs.reloadData()
        }
    func changeView(_ celda: UITableViewCell) {
        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "Player") as? AudioPlayerViewController
        guard let vc = vc else {return}
        vc.modalPresentationStyle = .fullScreen
        guard let indexPath = self.listSongs.indexPath(for: celda)else {return}
        if let delegate = self.listSongs.delegate {
            delegate.tableView!(self.listSongs, didEndDisplaying: celda, forRowAt: indexPath)
        }
        let info = songsArray[indexPath.row]

        print(info)
        vc.infoSong = info
          self.present(vc, animated: true)
    }
    
}
