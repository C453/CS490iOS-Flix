//
//  MovieDetailViewController.swift
//  Flix
//
//  Created by Case Wright on 1/14/19.
//  Copyright © 2019 Case Wright. All rights reserved.
//

import UIKit
import AlamofireImage

class MovieDetailViewController: UIViewController {
    @IBOutlet weak var posterView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UITextView!
    
    var movieTitle: String!
    var movieDescription: String!
    var posterURL: URL!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        titleLabel.text = movieTitle
        descriptionLabel.text = movieDescription
        posterView.af_setImage(withURL: posterURL)
        self.navigationItem.title = "Details"
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
