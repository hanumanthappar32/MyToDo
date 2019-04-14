//
//  CatogoryTableViewController.swift
//  MyToDo
//
//  Created by Ramesh H on 12/04/19.
//  Copyright © 2019 Ramesh H. All rights reserved.
//

import UIKit
import RealmSwift



class CatogoryTableViewController: UITableViewController  {
    let realm = try! Realm()
    
    
    var catogoryArry = [Category]()
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadCatogories()
        
    
    }
    
    //MARK: - Table View Data source methods
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return catogoryArry.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "CatogoryCell", for: indexPath)
        
        let newCatogory = catogoryArry [indexPath.row]
        cell.textLabel?.text = newCatogory.name
        return cell
        
    }
    
   
    //MARK: - Table View Delegate Methods
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "GoToItems", sender: self)
    }
    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! ViewController
        
        if  let indexpath = tableView.indexPathForSelectedRow {
            destinationVC.selectedCatogory = catogoryArry[indexpath.row]
            
            
        }
        
        
    }
    //MARK:- Table View Manupilation methods
    
    
    func save(category : Category) {
        do{
            try realm.write {
                realm.add(category)
            }
        }catch{
            print("Error saving catogory \(error)")
        }
        tableView.reloadData()
    }
   
    func loadCatogories() {
        /* let request : NSFetchRequest<Catogory> = Catogory.fetchRequest()
        do {
        catogoryArry = try context.fetch(request)
        }catch{
            print("error in fetching catories \(error)")
        }
        tableView.reloadData() */
    }


    
    @IBAction func AddButtonPressed(_ sender: UIBarButtonItem) {
       
        var textfield = UITextField()
        
        let alert = UIAlertController(title: "Add new Catogory" , message: "", preferredStyle: .alert )
        let action = UIAlertAction(title: "Add Catogory", style: .default) { (action) in
            //what will happen when "add person" is pressed
            
            let newCategory = Category()
            
        
             newCategory.name = textfield.text!
            //newitem.done = false
            self.catogoryArry.append(newCategory)
            
            //self.tableView.reloadData()
            //self.mydefault.set(self.persons, forKey: "personsList")
           self.save(category: newCategory)
        }
        alert.addAction(action)
        alert.addTextField { (field) in
            textfield = field
            textfield.placeholder = "Add new Catogory"
            // print(alertTextField.text as Any)
            //textfield = alertTextField
        }
        //alert.addAction(action)
        present(alert, animated: true,completion: nil)
        
    }
    
   
}
