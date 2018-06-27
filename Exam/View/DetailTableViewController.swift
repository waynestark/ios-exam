//
//  ViewController.swift
//  Exam
//
//  Created by HaochengLee on 2018/6/26.
//  Copyright © 2018 Examing. All rights reserved.
//

import UIKit

class DetailTableViewController: UIViewController {
    
    @IBOutlet var tableView: UITableView!
    
    var peronsDetail: NSDictionary! = nil;
    
    var list: List = List();
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let nib = UINib(nibName: "DetailTableCell", bundle: nil)
        self.tableView.register(nib, forCellReuseIdentifier: "DetailTableCell");
        self.tableView.delegate = self;
        self.tableView.dataSource = self;
        self.tableView.separatorStyle = .none;
        
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension DetailTableViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1;
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return list.GetList().count;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var cell: DetailTableCell! = tableView.dequeueReusableCell(withIdentifier: "DetailTableCell") as! DetailTableCell;
        
        if (cell == nil)
        {
            cell = DetailTableCell();
        }
        
        cell.selectionStyle = .none;
        cell.Title.text = list.GetList()[indexPath.row].title;
        
//        print(self.peronsDetail[list.GetList()[indexPath.row].tag]);
        
        if let p = self.peronsDetail
        {
            if let value = p[list.GetList()[indexPath.row].tag] as? String
            {
                cell.Info.text = value;
            }
            
            if let value = p[list.GetList()[indexPath.row].tag] as? Int
            {
                cell.Info.text = "\(value)";
            }
        }
        
        return cell;
    }
}

extension DetailTableViewController: UITableViewDelegate
{
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50.0;
    }
}
