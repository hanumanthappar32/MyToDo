//
//  ViewController.swift
//  MyToDo
//
//  Created by Ramesh H on 06/04/19.
//  Copyright © 2019 Ramesh H. All rights reserved.
//

import UIKit
import CoreData
class ViewController: UITableViewController {
    
    
    var persons = [Item] ()
    var selectedCatogory : Category? {
        didSet {
            //loadItems()
        }
    }
    
    
   
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        
     
    }
    //MARK: - Table view data source method
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return persons.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
     let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for:indexPath)
        
        let myitem = persons[indexPath.row]
        
        cell.textLabel?.text = myitem.title
        
        //ternary operator
        
        cell.accessoryType = myitem.done ? .checkmark : .none
        
       
        
        return cell
    }
    
    
    //MARK: - Tableview Delegate methods
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //print (persons[indexPath.row])
        
        //tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
        
        //context.delete(persons[indexPath.row])
        //persons.remove(at: indexPath.row)
       persons[indexPath.row].done = !persons[indexPath.row].done
        self.saveItems()
        //tableView.reloadData()
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    //MARK: - Add new person
  
    @IBAction func addbutton(_ sender: UIBarButtonItem) {
        
        var textfield = UITextField()
        
        let alert = UIAlertController(title: "Add new Person" , message: "", preferredStyle: .alert )
        let action = UIAlertAction(title: "Add Person", style: .default) { (action) in
            //what will happen when "add person" is pressed
           
           /* let newitem = Item(context: self.context)
            
            newitem.title = textfield.text!
            newitem.done = false
            newitem.parentCatogory = self.selectedCatogory
            self.persons.append(newitem)
            //self.tableView.reloadData()
            //self.mydefault.set(self.persons, forKey: "personsList")*/
            self.saveItems()
        }
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create new Person"
           // print(alertTextField.text as Any)
            textfield = alertTextField
        }
        alert.addAction(action)
        present(alert, animated: true,completion: nil)
        
        
    }
    func saveItems(){
        do{
           try context.save()
        }catch{
           print("Error saving context \(error)")
        }
        self.tableView.reloadData()
        
    }
    /*func loadItems(with request : NSFetchRequest<Item> = Item.fetchRequest(), predicate : NSPredicate? = nil) {
        
        let catogoryPredicate = NSPredicate(format: "parentCatogory.name MATCHES %@", selectedCatogory!.name!)
        
        if let additionalPredicate = predicate {
            request.predicate = NSCompoundPredicate(andPredicateWithSubpredicates: [catogoryPredicate,additionalPredicate])
        }else{
            request.predicate = catogoryPredicate
        }
        
      
        
        do{
        persons = try context.fetch(request)
        }catch{
            print("Error in fetching data \(error)")
        }
        tableView.reloadData()
    }*/
            
    
    
    
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


