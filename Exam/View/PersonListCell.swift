//
//  PersonListCell.swift
//  Exam
//
//  Created by HaochengLee on 2018/6/27.
//  Copyright © 2018 Examing. All rights reserved.
//

import UIKit

class PersonListCell: UITableViewCell {
    
    @IBOutlet var age: UILabel!
    
    @IBOutlet var name: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
