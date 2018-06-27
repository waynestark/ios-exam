//
//  Person.swift
//  Exam
//
//  Created by HaochengLee on 2018/6/26.
//  Copyright © 2018 Examing. All rights reserved.
//

import Foundation

struct Person {
    
    var
    
    firstName: String = "",
    lastName: String = "",
    birthday: String = "",
    age: Int = 0,
    emailAddress: String = "",
    mobileNumber: String = "",
    address: String = "",
    contactPerson: String = "",
    contactPersonNumber: String = ""
    
    init() {
        
    }
    
    init(
        firstName: String = "",
        lastName: String = "",
        birthday: String = "",
        age: Int = 0,
        emailAddress: String = "",
        mobileNumber: String = "",
        address: String = "",
        contactPerson: String = "",
        contactPersonNumber: String = ""
        )        
    {
        self.firstName = firstName;
        self.lastName = lastName;
        self.birthday = birthday;
        self.age = age;
        self.emailAddress = emailAddress;
        self.mobileNumber = mobileNumber;
        self.address = address;
        self.contactPerson = contactPerson;
        self.contactPersonNumber = contactPersonNumber;
    }
}
