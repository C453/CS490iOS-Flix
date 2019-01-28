//
//  MovieTableCell.swift
//  Flix
//
//  Created by Case Wright on 1/25/19.
//  Copyright © 2019 Case Wright. All rights reserved.
//

import UIKit

class MovieTableCell: UITableViewCell {
    @IBOutlet weak var posterView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var summaryLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
