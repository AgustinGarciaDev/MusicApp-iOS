//
//  PlayListDetailController.swift
//  Naranja Music
//
//  Created by Agustin Chinchilla on 29/11/2021.
//

import UIKit

class PlayListDetailController: UIViewController , TracksPickerDelegate {
    
   
    var songs = Set<Track>()
    var songsArray = [Track]()
    var viewSongs = TracksPickerView()
    var btnStatus = false
    
    var listSongs  : UITableView = {
        let table = UITableView()
        table.translatesAutoresizingMaskIntoConstraints = false
        return table
    }()
    
    func addTrack(song: Track) {
        
        for songOne in songsArray{
            if songOne == song {
                let alert = UIAlertController(title: "", message: "Esta cancion ya esta agregada", preferredStyle: UIAlertController.Style.alert)
                        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
                        self.present(alert, animated: true, completion: nil)
            }
        }
        songs.insert(song)
        songsArray = Array(songs)
        listSongs.reloadData()
        print("me ejecuto add ")
    }


    var inputText : UITextField = {
        let label = UITextField()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.placeholder = "Playlist..."
        label.tintColor = .orange
        label.backgroundColor = .orange
        label.sizeToFit()
        return label
    }()
    
    var btnAddSong : UIButton = {
        let btn = UIButton()
        btn.backgroundColor = .black
        btn.setImage(UIImage(systemName: "plus"), for: .normal)
        btn.translatesAutoresizingMaskIntoConstraints = false

        return btn
    }()
    
 
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
        
        
        listSongs.backgroundColor = .gray
        self.view.addSubview(listSongs)
        NSLayoutConstraint.activate([
           listSongs.topAnchor.constraint(equalTo: inputText.bottomAnchor, constant: 10 ),
            listSongs.bottomAnchor.constraint(equalTo: safeA.bottomAnchor, constant: -5),
            listSongs.leadingAnchor.constraint(equalTo: safeA.leadingAnchor, constant: 25),
            listSongs.trailingAnchor.constraint(equalTo: safeA.trailingAnchor,constant: -12),
        ])
        listSongs.delegate = self
        listSongs.dataSource = self
        listSongs.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        
    }
    
    @objc func callSubView(){
        
    btnStatus = !btnStatus
    viewSongs.trackDelegate = self
    btnStatus ? self.view.addSubview(viewSongs) : viewSongs.removeFromSuperview()

    }


}



extension  PlayListDetailController : UITableViewDataSource  {
    func numberOfSections(in tableView: UITableView) -> Int {
       // #warning Incomplete implementation, return the number of sections
       return 1
   }
   
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return songsArray.count
      }
    

}

extension PlayListDetailController : UITableViewDelegate {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
      let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
      let song = songsArray[indexPath.row]
      cell.textLabel?.text = song.title
      return cell
    }
}
