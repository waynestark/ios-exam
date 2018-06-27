//
//  ListItemViewController.swift
//  Exam
//
//  Created by HaochengLee on 2018/6/27.
//  Copyright © 2018 Examing. All rights reserved.
//

import UIKit

class PersonListTableViewController: UIViewController {
    
    @IBOutlet var tableView: UITableView!
    
    var club: Club!;
    
    var peronsDetail: [NSDictionary?] = [];
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.club = Club(delegate: self);
        
        let nib = UINib(nibName: "PersonListCell", bundle: nil)
        self.tableView.register(nib, forCellReuseIdentifier: "Cell");
        self.tableView.dataSource = self;
        self.tableView.delegate = self;
        self.tableView.separatorStyle = .none;
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

extension PersonListTableViewController: UITableViewDataSource
{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1;
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.club.persons.count;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var cell: PersonListCell! = tableView.dequeueReusableCell(withIdentifier: "Cell") as! PersonListCell;
        if (cell == nil)
        {
            cell = PersonListCell();
        }
        
        cell.selectionStyle = .none;
        cell.age.text = "\(self.club.persons[indexPath.row].age)";
        cell.name.text = "\(self.club.persons[indexPath.row].firstName)" + " " + "\(self.club.persons[indexPath.row].lastName)";
        
        return cell!;
    }
}

extension PersonListTableViewController: UITableViewDelegate
{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath.row);
        
        var pushViewController: DetailTableViewController!;
        
        if let s = self.storyboard
        {
            pushViewController = s.instantiateViewController(withIdentifier: NSStringFromClass(DetailTableViewController.self)) as! DetailTableViewController
        }
        else
        {
            pushViewController = DetailTableViewController();
        }
        
        if (pushViewController == nil)
        {
            pushViewController = DetailTableViewController();
        }
        
        pushViewController.peronsDetail = self.peronsDetail[indexPath.row];
        
        self.navigationController?.pushViewController(pushViewController, animated: true);
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50.0;
    }
}

extension PersonListTableViewController: ClubDelegate
{
    func OnClubPersonCountChanged(perons: [Person]) {
        
        for p in perons
        {
            let dic: NSMutableDictionary = NSMutableDictionary();
            dic["address"] = p.address;
            dic["firstname"] = p.firstName;
            dic["lastname"] = p.lastName;
            dic["birthday"] = p.birthday;
            dic["age"] = p.age;
            dic["mobilenumber"] = p.mobileNumber;
            dic["emailaddress"] = p.emailAddress;
            dic["address"] = p.address;
            dic["contactperson"] = p.contactPerson;
            dic["contactpersonnumber"] = p.contactPersonNumber;
            self.peronsDetail.append(dic);
        }
        
        self.tableView.reloadData();
    }
}
