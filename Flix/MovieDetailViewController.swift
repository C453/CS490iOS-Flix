//
//  MovieDetailViewController.swift
//  Flix
//
//  Created by Case Wright on 1/14/19.
//  Copyright © 2019 Case Wright. All rights reserved.
//

import UIKit
import AlamofireImage
import YouTubePlayer
import Cosmos

class MovieDetailViewController: UIViewController, YouTubePlayerDelegate {
    @IBOutlet weak var posterView: UIImageView!
    @IBOutlet weak var backgroundView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UITextView!
    @IBOutlet weak var videoPlayer: YouTubePlayerView!
    @IBOutlet weak var ratingView: CosmosView!
    
    var movieTitle: String!
    var backgroundURL: URL!
    var movieDescription: String!
    var posterURL: URL!
    var movieID: String!
    var rating: Double!
    
    var videos = [[String:Any]]()
    
    var lastLocation:CGPoint = CGPoint(x: 0, y: 0)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getTrailerKey()
        
        self.view.isUserInteractionEnabled = true
        
        
        let panRecognizer = UIPanGestureRecognizer(target:self, action:#selector(self.handlePan))
        self.view.addGestureRecognizer(panRecognizer)
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.handleTap))
        tapGestureRecognizer.numberOfTapsRequired = 1
        self.posterView.isUserInteractionEnabled = true
        self.posterView.addGestureRecognizer(tapGestureRecognizer)
        
        titleLabel.text = movieTitle
        descriptionLabel.text = movieDescription
        posterView.af_setImage(withURL: posterURL)
        backgroundView.af_setImage(withURL: backgroundURL)
        self.navigationItem.title = "Details"
        
        posterView.layer.borderColor = UIColor.white.cgColor
        posterView.layer.borderWidth = 2.0
        posterView.layer.cornerRadius = 5.0
        
        ratingView.rating = rating
        
        videoPlayer.delegate = self
    }
    
    @objc func handlePan(sender:UIPanGestureRecognizer)  {
        let touchPoint = sender.location(in: self.view?.window)
        
        if sender.state == UIGestureRecognizer.State.began {
            lastLocation = touchPoint
        } else if sender.state == UIGestureRecognizer.State.changed {
            if touchPoint.y - lastLocation.y > 0 {
                self.view.frame = CGRect(x: 0, y: touchPoint.y - lastLocation.y, width: self.view.frame.size.width, height: self.view.frame.size.height)
            }
        } else if sender.state == UIGestureRecognizer.State.ended || sender.state == UIGestureRecognizer.State.cancelled {
            if touchPoint.y - lastLocation.y > 100 {
                self.dismiss(animated: true, completion: nil)
            } else {
                UIView.animate(withDuration: 0.3, animations: {
                    self.view.frame = CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: self.view.frame.size.height)
                })
            }
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        lastLocation = self.view.center
    }
    
    @objc func handleTap(sender:UITapGestureRecognizer)  {
    }
    
    @IBAction func closePlayer(_ sender: Any) {
        
        videoPlayer.stop()
        videoPlayer.isHidden = true
    }
    
    func getTrailerKey() {
        let url = URL(string: "https://api.themoviedb.org/3/movie/\(movieID!)/videos?api_key=a07e22bc18f5cb106bfe4cc1f83ad8ed&language=en-US")!
        let request = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 10)
        let session = URLSession(configuration: .default, delegate: nil, delegateQueue: OperationQueue.main)
        let task = session.dataTask(with: request) { (data, response, error) in
            // This will run when the network request returns
            if let error = error {
                print(error.localizedDescription)
            } else if let data = data {
                let dataDictionary = try! JSONSerialization.jsonObject(with: data, options: []) as! [String: Any]
                self.videos = dataDictionary["results"] as! [[String : Any]]
                
                let trailerIndex = self.videos[0]
                let trailerKey = trailerIndex["key"] as! String
                self.videoPlayer.loadVideoID(trailerKey)
            }
        }
        task.resume()
    }
    
    func playerReady(_ videoPlayer: YouTubePlayerView) {
        videoPlayer.isHidden = false
        videoPlayer.pause()
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    }
}
