//
//  PlayListDetailController.swift
//  Naranja Music
//
//  Created by Agustin Chinchilla on 29/11/2021.
//

import UIKit

class PlayListDetailController: UIViewController , TracksPickerDelegate {

    var viewSongs = TracksPickerView()
    var btnStatus = false
    var viewModel : PlayListDetailModel?
   
    
    var listSongs  : UITableView = {
        let table = UITableView()
        table.translatesAutoresizingMaskIntoConstraints = false
        return table
    }()
    
    var inputText : UITextField = {
        let label = UITextField()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.placeholder = "Playlist..."
        label.textColor = .black
        label.leftViewMode = UITextField.ViewMode.always
        label.backgroundColor = .white
        label.layer.cornerRadius = 20
        label.sizeToFit()
        return label
    }()
    
    var btnAddSong : UIButton = {
        let btn = UIButton()
        let configurationIcon = UIImage.SymbolConfiguration(
            pointSize: 32, weight: .medium, scale: .default)
        btn.backgroundColor = .black
        btn.setImage(UIImage(systemName: "plus.rectangle.fill.on.rectangle.fill", withConfiguration: configurationIcon), for: .normal)
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
        
        inputText.addTarget(self, action: #selector(searchSong(_:)), for: .editingChanged)
        self.view.addSubview(inputText)
        NSLayoutConstraint.activate([
            inputText.topAnchor.constraint(equalTo: safeA.topAnchor,constant: 5),
            inputText.leadingAnchor.constraint(equalTo: safeA.leadingAnchor , constant: 25),
            inputText.trailingAnchor.constraint(equalTo: safeA.trailingAnchor , constant:  -100),
            inputText.heightAnchor.constraint(equalToConstant: 55),
        ])
        
        self.view.addSubview(btnAddSong)
        NSLayoutConstraint.activate([
            btnAddSong.topAnchor.constraint(equalTo: safeA.topAnchor,constant: 15),
            btnAddSong.leadingAnchor.constraint(equalTo: inputText.trailingAnchor, constant: 15),
            btnAddSong.trailingAnchor.constraint(equalTo: safeA.trailingAnchor , constant:  -15),

        ])
        btnAddSong.addTarget(self, action: #selector(callSubView), for: .touchUpInside)
        
        
        listSongs.backgroundColor = .black
        self.view.addSubview(listSongs)
        NSLayoutConstraint.activate([
           listSongs.topAnchor.constraint(equalTo: inputText.bottomAnchor, constant: 20 ),
            listSongs.bottomAnchor.constraint(equalTo: safeA.bottomAnchor, constant: -5),
            listSongs.leadingAnchor.constraint(equalTo: safeA.leadingAnchor, constant: 0),
            listSongs.trailingAnchor.constraint(equalTo: safeA.trailingAnchor,constant: 0),
        ])
        listSongs.register(TrackTableViewCell.self, forCellReuseIdentifier: "reuseIdentifier")
        listSongs.delegate = viewModel!
        listSongs.dataSource = viewModel!
        listSongs.rowHeight = 80.0
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        viewModel?.reloadDataDelegate?.reloadDataTable()
    }
    
    @objc func callSubView(){
        viewModel?.showViewDelegate?.showView()
    }
    
    @objc func searchSong(_ textField: UITextField){
        viewModel?.showViewDelegate?.searchSongBar(textField)
    }
    
    func addTrack(song: Track) {
        
        viewModel?.addSongTable(song)

    }
    
    override func viewWillDisappear(_ animated: Bool) {
        viewModel?.reloadDataDelegate?.reloadDataTable()
    }
    
    }

