//
//  ViewController.swift
//  mathstests
//
//  Created by Ross Harrison on 07/08/18.
//  Copyright © 2018 Ross Harrison. All rights reserved.
//


import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var colours: Array = [#colorLiteral(red: 0.05098039216, green: 0.6784313725, blue: 0.07450980392, alpha: 1), #colorLiteral(red: 0.9960784314, green: 1, blue: 0.2666666667, alpha: 1), #colorLiteral(red: 1, green: 0.6517646849, blue: 0.05509868973, alpha: 1), #colorLiteral(red: 0.9568627451, green: 0.1019607843, blue: 0.1019607843, alpha: 1), #colorLiteral(red: 0.8874525428, green: 0.2848415971, blue: 0.6302366853, alpha: 1)]
    
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
        destinationView!.difficultyColourFromSegue = colours[indexPath]
        
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
        cell.textLabel!.textColor = colours[indexPath.row]
        cell.textLabel!.textAlignment = NSTextAlignment.center
        cell.textLabel?.font = UIFont.boldSystemFont(ofSize: scaleText(80))
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "difficultySelected", sender: self)
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UIScreen.main.bounds.height / CGFloat((difficulties.count + 1))
    }
    
    func scaleText(_ sizeOniPad: Int) -> CGFloat {
        return CGFloat(sizeOniPad) * UIScreen.main.bounds.width / 768.0
    }
}

