//
//  ViewController.swift
//  MyToDo
//
//  Created by Ramesh H on 06/04/19.
//  Copyright © 2019 Ramesh H. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {
    
    
    var persons = [Items] ()
    
    let mydefault = UserDefaults.standard

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let newperson = Items()
            newperson.name = "Ramesh"
            persons.append(newperson)
        
        let newperson1 = Items()
        newperson1.name = "Jalaja"
        persons.append(newperson1)
        
        let newperson2 = Items()
        newperson2.name = "Shilpa"
        persons.append(newperson2)
        
        if let items = mydefault.array(forKey: "personsList") as? [Items] {
            persons = items
        }
        // Do any additional setup after loading the view.
    }
    //Mark - Table view data source method
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return persons.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
     let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for:indexPath)
        
        let myitem = persons[indexPath.row]
        
        cell.textLabel?.text = myitem.name
        
        //ternary operator
        
        cell.accessoryType = myitem.done ? .checkmark : .none
        
       
        
        return cell
    }
    
    
//Mark - Tableview Delegate methods
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //print (persons[indexPath.row])
        
        //tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
       persons[indexPath.row].done = !persons[indexPath.row].done
        
        tableView.reloadData()
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    //MARK - Add new person
  
    @IBAction func addbutton(_ sender: UIBarButtonItem) {
        
        var textfield = UITextField()
        
        let alert = UIAlertController(title: "Add new Person" , message: "", preferredStyle: .alert )
        let action = UIAlertAction(title: "Add Person", style: .default) { (action) in
            //what will happen when "add person" is pressed
           let newitem = Items()
            newitem.name = textfield.text!
            self.persons.append(newitem)
            self.tableView.reloadData()
            self.mydefault.set(self.persons, forKey: "personsList")
        }
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create new Person"
           // print(alertTextField.text as Any)
            textfield = alertTextField
        }
        alert.addAction(action)
        present(alert, animated: true,completion: nil)
        
    }
    
}


