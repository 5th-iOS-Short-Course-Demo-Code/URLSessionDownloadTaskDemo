//
//  ViewController.swift
//  URLSessionDownloadTaskDemo
//
//  Created by Chhaileng Peng on 8/25/18.
//  Copyright © 2018 Chhaileng Peng. All rights reserved.
//

import UIKit

class ViewController: UIViewController, URLSessionDelegate, URLSessionDownloadDelegate {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var progressView: UIProgressView!
    
    @IBAction func downloadClick(_ sender: UIButton) {
        progressView.isHidden = false
        progressView.progress = 0
        imageView.image = nil
        
        let url = URL(string: "https://wallpapershome.com/images/wallpapers/macos-mojave-3570x2078-night-dunes-wwdc-2018-4k-18883.jpg")
        let config = URLSessionConfiguration.default
        
        let urlSession = URLSession(configuration: config, delegate: self, delegateQueue: nil)
        
        // Use shared instance as default configuration
        //let session = URLSession.shared
        
        let downloadTask = urlSession.downloadTask(with: url!)
        downloadTask.resume()
        
    }
    
    func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didFinishDownloadingTo location: URL) {
        let data = try? Data(contentsOf: location)
        DispatchQueue.main.async {
            self.imageView.image = UIImage(data: data!)
            self.progressView.isHidden = true
        }
    }
    
    func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didWriteData bytesWritten: Int64, totalBytesWritten: Int64, totalBytesExpectedToWrite: Int64) {
        
        
        let progress = Float(totalBytesWritten) / Float(totalBytesExpectedToWrite)
        DispatchQueue.main.async {
            self.progressView.progress = progress
        }
        
        
    }
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        progressView.isHidden = true
        
        
    }


}

