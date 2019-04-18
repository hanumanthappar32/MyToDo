//
//  ViewController.swift
//  MyToDo
//
//  Created by Ramesh H on 06/04/19.
//  Copyright © 2019 Ramesh H. All rights reserved.
//

import UIKit
import RealmSwift

class ViewController: UITableViewController {
    
    
    var persons: Results<Item>?
    let realm = try! Realm()
    
    var selectedCatogory : Category? {
        didSet {
            loadItems()
        }
    }
    
    
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        
     
    }
    //MARK: - Table view data source method
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return persons?.count ?? 1
        
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
     let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for:indexPath)
        
        if let myitem = persons?[indexPath.row]{
        
        cell.textLabel?.text = myitem.title
        
        //ternary operator
        
        cell.accessoryType = myitem.done ? .checkmark : .none
        
        }else{
        
        cell.textLabel?.text = "No Item Is Added Yet"
        
        
        }
        return cell
    }
    
    
    //MARK: - Tableview Delegate methods
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if let myperson  = persons?[indexPath.row] {
            
            do {
                try realm.write {
                    myperson.done = !myperson.done
                }
            }catch {
                print("Error in saving persons \(error)")
            }
            
            
        }
        
        
        
        //print (persons[indexPath.row])
        
        //tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
        
        //context.delete(persons[indexPath.row])
        //persons.remove(at: indexPath.row)
      // persons[indexPath.row].done = !persons[indexPath.row].done
       // self.saveItems()
        tableView.reloadData()
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    //MARK: - Add new person
  
    @IBAction func addbutton(_ sender: UIBarButtonItem) {
        
        var textfield = UITextField()
        
        let alert = UIAlertController(title: "Add new Person" , message: "", preferredStyle: .alert )
        let action = UIAlertAction(title: "Add Person", style: .default) {
            (action) in
            //what will happen when "add person" is pressed
            
            if let currentCategory = self.selectedCatogory {
            
            do {
                try! self.realm.write {
                    let newitem = Item()
                    newitem.title = textfield.text!
                    currentCategory.items.append(newitem)
                }
            
           
               
            } catch {
            
                print("Error in saving Item \(error)")
            }
        }
            self.tableView.reloadData()
        }
       
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create new Person"
           // print(alertTextField.text as Any)
            textfield = alertTextField
        }
        alert.addAction(action)
        present(alert, animated: true,completion: nil)
        
        
    }
    /*func saveItems(){
        do{
           try context.save()
        }catch{
           print("Error saving context \(error)")
        }
        self.tableView.reloadData()
        
    }*/
    func loadItems() {
        
       persons = selectedCatogory?.items.sorted(byKeyPath: "title", ascending: true)
        tableView.reloadData()
    }
            
    
    
    
}

//MARK: - Search bar methods
/*extension ViewController : UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        let request : NSFetchRequest<Item> = Item.fetchRequest()
         let predicate = NSPredicate(format: "title CONTAINS %@", searchBar.text!)
        
        request.sortDescriptors = [NSSortDescriptor(key: "title", ascending: true)]
       
        loadItems(with: request, predicate: predicate)
        
        //print(searchBar.text!)
    }
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchBar.text?.count == 0 {
            loadItems()
            DispatchQueue.main.async {
                searchBar.resignFirstResponder()
            }
        }
    }
    
}*/


