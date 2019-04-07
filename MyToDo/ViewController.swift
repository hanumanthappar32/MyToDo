//
//  ViewController.swift
//  MyToDo
//
//  Created by Ramesh H on 06/04/19.
//  Copyright © 2019 Ramesh H. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {
    
    
    let persons = ["Ramesh", "Jalaja", "shilpa", "Adarsh", "Sheetal"]

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    //Mark - Table view data source method
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return persons.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
     let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for:indexPath)
        cell.textLabel?.text = persons[indexPath.row]
        return cell
    }
    
    
//Mark - Tableview Delegate methods
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //print (persons[indexPath.row])
        
        //tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
        
        if tableView.cellForRow(at: indexPath)?.accessoryType  == .checkmark  {
           tableView.cellForRow(at: indexPath)?.accessoryType  = .none
            
        } else {
        tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
        }
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

