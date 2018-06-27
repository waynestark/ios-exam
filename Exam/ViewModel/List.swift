//
//  List.swift
//  Exam
//
//  Created by HaochengLee on 2018/6/27.
//  Copyright © 2018 Examing. All rights reserved.
//

import UIKit

class List: NSObject {
    
    private var items: [ListItem];
    
    init(items: [ListItem]) {
        self.items = items;
        super.init();
    }
    
    convenience override init() {
        self.init(items: Array.init());
        
        self.items.append(self.buildItem(title: "First name", tag: "firstname", type: String.self));
        self.items.append(self.buildItem(title: "Last name",tag: "lastname", type: String.self));
        self.items.append(self.buildItem(title: "Birthday",tag: "birthday", type: String.self));
        self.items.append(self.buildItem(title: "Age",tag: "age", type: Int.self));
        self.items.append(self.buildItem(title: "Email address",tag: "emailaddress", type: String.self));
        self.items.append(self.buildItem(title: "Mobile number",tag: "mobilenumber", type: String.self));
        self.items.append(self.buildItem(title: "Address",tag: "address", type: String.self));
        self.items.append(self.buildItem(title: "Contact person",tag: "contactperson", type: String.self));
        self.items.append(self.buildItem(title: "Contact person's phone number",tag: "contactpersonnumber", type: String.self));
        
    }
    
    private func buildItem(title: String, tag: String, type: Any) -> ListItem
    {
        let item: ListItem = ListItem(title: title, tag: tag, type: type);
        return item;
    }
    
    internal func GetList() -> [ListItem]
    {
        return self.items;
    }
    
}
