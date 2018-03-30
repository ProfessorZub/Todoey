//
//  CategoryViewController.swift
//  Todoey
//
//  Created by Miguel Diez on 3/28/18.
//  Copyright © 2018 Professor Z, LLC. All rights reserved.
//

import UIKit
import RealmSwift

class CategoryViewController: UITableViewController {

    let realm = try! Realm()
    
    var categories : Results<Category>?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Read from database and load some data into the context
        loadCategories()
    }

    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        var textField = UITextField()
        
        print("Button Pressed. Adding category...")
        let alert = UIAlertController(title: "Add New Todoey Category", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add Category", style: .default) {(action) in

            let newCategory = Category()
            newCategory.name = textField.text!
            
            // In Realm implementation, categories is auto updated so we do not neet to append to it. In fact, categories is not an array anymore but of Results<Category> type, as seen above
//            self.categories.append(newCategory)
            
            self.save(category: newCategory)
    }
        //Add a text field to the alert to capture the input from the user
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create new item"
            textField = alertTextField
            
        }
        
        alert.addAction(action)
        
        present(alert, animated: true, completion: nil)
}
    
    //MARK: - TableView Datasource Methods
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // If categories (which is an optional) is not nil, return .count. Else, return 1:
        // (This syntax is called Nil Coalescing Operator)
        return categories?.count ?? 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell", for: indexPath)
        
        let category = categories![indexPath.row]
        
        cell.textLabel?.text = category.name
        
        return cell
    }

    //MARK: - TableView Delegate Methods
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        performSegue(withIdentifier: "goToItems", sender: self)

    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! TodoListViewController
        
        if let indexPath = tableView.indexPathForSelectedRow {
            destinationVC.selectedCategory = categories?[indexPath.row]
        }
    }
    
    //MARK: - Data Manipulation Methods
    func loadCategories() {
    
        categories = realm.objects(Category.self)
        
        tableView.reloadData()
        
    }
    
    func save(category: Category) {
            
            do {
                try realm.write {
                    realm.add(category)
                }
                
            } catch {
                print("Error saving context \(error))")
            }
            
            self.tableView.reloadData()
        }
    
}
