//
//  ViewController.swift
//  mathstests
//
//  Created by Ross Harrison on 07/08/18.
//  Copyright © 2018 Ross Harrison. All rights reserved.
//


import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    let difficulties: Array<String> = ["Underling", "Intermediate", "Hard", "Insane", "Über"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tablesTable.delegate = self
        tablesTable.dataSource = self
        tablesTable.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
    }

    @IBOutlet var tablesTable: UITableView!
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return difficulties.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UITableViewCell = tablesTable.dequeueReusableCell(withIdentifier: "cell")!
        
        cell.textLabel!.text = difficulties[indexPath.row]
        
        return cell
    }
    
}

