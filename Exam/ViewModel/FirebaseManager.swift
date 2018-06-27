//
//  FirebaseManager.swift
//  Exam
//
//  Created by HaochengLee on 2018/6/27.
//  Copyright © 2018 Examing. All rights reserved.
//

import UIKit
import Firebase;
import FirebaseDatabase;
import FirebaseAuth;

protocol FirebaseManagerDelegate {
    func OnGetAllPersonsData(datas: [Any?]);
}

class FirebaseManager: NSObject {
    
    static let singleton = FirebaseManager();
    
    var ref: DatabaseReference! = nil
    
    var delegate: FirebaseManagerDelegate! = nil
    
    private override init() {
        print("Firebase Manager init...");
    }
    
    deinit
    {
        print("Firebase Manager deinit...");
    }
    
    internal func initializeFirebase(delegate: FirebaseManagerDelegate)
    {
        self.delegate = delegate;
        FirebaseApp.configure();
        
//        Database.database().isPersistenceEnabled = true;
        
        self.ref = Database.database().reference();
        
        print("Initialize Firebase...");
    }
    
    internal func getAllPersonsData()
    {
        ref.child("persons").observeSingleEvent(of: .value, with: {
            
            (snapshot) in
            
            // Get value
            
            var snaps: [Any?] = [];
            
            for child in snapshot.children {
                let snap = child as! DataSnapshot
                snaps.append(snap.value);
            }
            
            if (self.delegate != nil)
            {
                self.delegate.OnGetAllPersonsData(datas: snaps);
            }
            
        }) { (error) in
            print(error.localizedDescription)
        }
    }
}
