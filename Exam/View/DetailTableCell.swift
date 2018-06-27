//
//  PersonDetailCell.swift
//  Exam
//
//  Created by HaochengLee on 2018/6/26.
//  Copyright © 2018 Examing. All rights reserved.
//

import UIKit

class DetailTableCell: UITableViewCell {
    
    @IBOutlet var Title: UILabel!
    @IBOutlet var Info: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
