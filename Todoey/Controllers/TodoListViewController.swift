//
//  ViewController.swift
//  Todoey
//
//  Created by Miguel Diez on 3/19/18.
//  Copyright © 2018 Professor Z, LLC. All rights reserved.
//

import UIKit

class TodoListViewController: UITableViewController {

 //   var itemArray = ["Find Mike", "Buy Eggos", "Deztroy Demagorgon"]
    
    var itemArray = [Item]()
    
    let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("Items.plist")
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        print(dataFilePath)
        
        let newItem1 = Item()
        newItem1.title = "Find Mike"
        itemArray.append(newItem1)
        
        let newItem2 = Item()
        newItem2.title = "Buy Eggos"
        itemArray.append(newItem2)
        
        let newItem3 = Item()
        newItem3.title = "Deztroy Demagorgon"
        itemArray.append(newItem3)
        
        loadItems()
        
//          //Old implementation with User Defaults
//        if let items = defaults.array(forKey: "TodoListArray") as? [Item] {
//            itemArray = items
//       }
    }
    
    //MARK - TableView Datasource Methods
    override func numberOfSections(in tableView: UITableView) -> Int {
        //Only one section with all the cells one after another
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        //this implementation has hardwired data for test
        return itemArray.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        //
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        
        let item = itemArray[indexPath.row]
        
        cell.textLabel?.text = item.title
        
        //Ternary operator:
        // value = condition ? valueIfTrue : valueIfFalse
        
        cell.accessoryType = item.done ? .checkmark : .none
        
        // implementatio prior to ternary operator
//        if item.done == true {
//            cell.accessoryType = .checkmark
//        } else {
//            cell.accessoryType = .none
//        }
        
        return cell
    }
    
    //MARK - TableView Delegate Methods
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        //Set and remove checklist mark
        itemArray[indexPath.row].done = !itemArray[indexPath.row].done
        
        saveItems()
        
        //Deselect row to remove the grey highlight for UI beautification purposes
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    //MARK - Add New Items
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        var textField = UITextField()
        
        print("Button Pressed. Let's try that alert thingy...")
        let alert = UIAlertController(title: "Add New Todoey Item", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add Item", style: .default) {(action) in
            //what happens when I press the Add Item button goes here
            print(textField.text!)
            
            let newItem = Item()
            newItem.title = textField.text!
            
            self.itemArray.append(newItem)
            
            self.saveItems()
            
           //old implementation with user defaults
           // self.defaults.set(self.itemArray, forKey: "TodoListArray")

        }
        
        //Add a text field to the alert to capture the input from the user
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create new item"
        textField = alertTextField
            
        }
        
        alert.addAction(action)
        
        present(alert, animated: true, completion: nil)
    }
    
    //MARK - Model Manipulation Methods
    
    func saveItems() {
        
        let encoder = PropertyListEncoder()
        
        do {
            let data = try encoder.encode(itemArray)
            try data.write(to: dataFilePath!)
        } catch {
            print("Error encoding data \(error))")
        }
        
        self.tableView.reloadData()
    }
    
    func loadItems() {
        
        let decoder = PropertyListDecoder()
        
        do {
            //read plist from dataFilePath
            //decode data and pace into itemArray
            let data = try Data(contentsOf: dataFilePath!)
            itemArray = try decoder.decode([Item].self, from: data)
            
        } catch {
            print("Error loading data \(error))")
        }
        
        self.tableView.reloadData()
        
    }
    
    //MARK - Other overrides

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

