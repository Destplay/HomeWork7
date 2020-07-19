//
//  FeedTableViewCell.swift
//  OTUS
//
//  Created by Дмитрий Матвеенко on 16/06/2019.
//  Copyright © 2019 GkFoxes. All rights reserved.
//

import UIKit

class FeedTableViewCell: UITableViewCell {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    
    static let reuseID = String(describing: FeedTableViewCell.self)
    
    func updateCell(name: String, time: String, color: UIColor) {
        self.nameLabel.text = name
        self.timeLabel?.text = time
        self.timeLabel?.textColor = color
    }
}
