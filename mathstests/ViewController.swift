//
//  ViewController.swift
//  mathstests
//
//  Created by Ross Harrison on 07/08/18.
//  Copyright © 2018 Ross Harrison. All rights reserved.
//


import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var colours: Array = [#colorLiteral(red: 0.1764705926, green: 0.01176470611, blue: 0.5607843399, alpha: 1), #colorLiteral(red: 0.1960784346, green: 0.3411764801, blue: 0.1019607857, alpha: 1)]
    
    let difficulties: Array<String> = ["Underling", "Intermediate", "Hard", "Insane", "Über"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tablesTable.delegate = self
        tablesTable.dataSource = self
        tablesTable.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tablesTable.tableFooterView = UIView()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationView = segue.destination as? QuestionViewController
        let indexPath = tablesTable.indexPathForSelectedRow!.row
        destinationView!.difficultyStringFromSegue = difficulties[indexPath]
        
        if segue.identifier == "difficultySelected" {
            tablesTable.deselectRow(at: tablesTable.indexPathForSelectedRow!, animated: true)
        }
    }

    @IBOutlet var tablesTable: UITableView!
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return difficulties.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UITableViewCell = tablesTable.dequeueReusableCell(withIdentifier: "cell")!
        
        cell.textLabel!.text = difficulties[indexPath.row]
        cell.textLabel!.textColor = colours[indexPath.row % 2]
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "difficultySelected", sender: self)
    }
}

