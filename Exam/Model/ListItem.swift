//
//  ListItem.swift
//  Exam
//
//  Created by HaochengLee on 2018/6/26.
//  Copyright © 2018 Examing. All rights reserved.
//

import Foundation

struct ListItem
{
    var title: String;
    var tag: String;
    var type: Any;
    
    init(title: String, tag: String, type: Any) {
        self.title = title;
        self.tag = tag;
        self.type = type;
    }
}
