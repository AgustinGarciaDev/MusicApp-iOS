//
//  DownloadManager.swift
//  Naranja Music
//
//  Created by Agustin Chinchilla on 09/12/2021.
//

import Foundation


class DownloadManager : NSObject, ObservableObject{
    
    static var shared = DownloadManager()

    var celda : [String: TrackTableViewCell]?
    private var urlSession: URLSession!

    @Published var taks: [URLSessionTask] = []
    
    override private init(){
        super.init()
        let config  = URLSessionConfiguration.background(withIdentifier: "\(String(describing: Bundle.main.bundleIdentifier)).background")
        
        urlSession = URLSession(configuration: config, delegate: self, delegateQueue: OperationQueue())
        updateTasks()
    }
    
    func startDownload(_ url: URL){
        let task = urlSession.downloadTask(with: url)
        task.resume()
        taks.append(task)
    }
    
    private func updateTasks(){
        urlSession.getAllTasks{ task in
            
            DispatchQueue.main.async {
                self.taks = task
            }
            
        }
    }
}

extension DownloadManager  : URLSessionDelegate, URLSessionDownloadDelegate{
   
    
    func urlSession (_: URLSession, downloadTask: URLSessionDownloadTask, didWriteData _: Int64, totalBytesWritten _: Int64, totalBytesExpectedToWrite _: Int64){
        
       let progress = downloadTask.progress.fractionCompleted
        
        
        NotificationCenter.default.post(name: NSNotification.Name("updateTable"), object: progress , userInfo: celda)
    }
    
    func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didFinishDownloadingTo location: URL) {
        print("Download Finished: \(location.absoluteString)")
    }
    
    func urlSession(_ session: URLSession, task: URLSessionTask, didCompleteWithError error: Error?) {
        if let error = error {
            print(error)
        }else{
            print("task finish")
        }
    }
    
}
