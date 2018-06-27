//
//  Club.swift
//  Exam
//
//  Created by HaochengLee on 2018/6/26.
//  Copyright © 2018 Examing. All rights reserved.
//

import UIKit

protocol ClubDelegate {
    func OnClubPersonCountChanged(perons: [Person]);
}

class Club: NSObject {
    
    internal var persons: [Person]
    {
        didSet
        {
            if (self.delegate != nil)
            {
                self.delegate!.OnClubPersonCountChanged(perons: self.persons);
            }
        }
    };
    
    private var delegate: ClubDelegate? = nil;
    
    init(persons:[Person], delegate: ClubDelegate) {
        self.persons = persons;
        self.delegate = delegate;
        super.init();
    }
    
    convenience init(delegate: ClubDelegate) {
        self.init(persons: Array.init(), delegate: delegate);
        self.gettingPersonsInfo();
    }
    
    private func gettingPersonsInfo() {
        FirebaseManager.singleton.initializeFirebase(delegate: self);
        FirebaseManager.singleton.getAllPersonsData();
    }
    
}

extension Club: FirebaseManagerDelegate
{
    func OnGetAllPersonsData(datas: [Any?]) {
        
        var _persons: [Person] = [];
        for pair in datas {
            if let data = pair as? NSDictionary {
                let person = self.analyzingPersonData(data: data);
                _persons.append(person);
            }
        }
        self.persons = _persons;
    }
    
    func analyzingPersonData(data: NSDictionary) -> Person
    {
        var person: Person = Person();
        
        if let value = data["firstname"] as? String
        {
            person.firstName = value;
        }
        
        if let value = data["lastname"] as? String
        {
            person.lastName = value;
        }
        
        if let value = data["mobilenumber"] as? String
        {
            person.mobileNumber = value;
        }
        
        if let value = data["birthday"] as? String
        {
            person.birthday = value;
        }
        
        if let value = data["age"] as? Int
        {
            person.age = value;
        }
        
        if let value = data["emailaddress"] as? String
        {
            person.emailAddress = value;
        }
        
        if let value = data["address"] as? String
        {
            person.address = value;
        }
        
        if let value = data["contactperson"] as? String
        {
            person.contactPerson = value;
        }
        
        if let value = data["contactpersonnumber"] as? String
        {
            person.contactPersonNumber = value;
        }
        
        print(person);
        
        return person;
    }
}
