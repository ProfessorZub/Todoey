//
//  ViewController.swift
//  Todoey
//
//  Created by Miguel Diez on 3/19/18.
//  Copyright © 2018 Professor Z, LLC. All rights reserved.
//

import UIKit

class TodoListViewController: UITableViewController {

    let itemArray = ["Find Mike", "Buy Eggos", "Deztroy Demagorgon"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
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
        
        cell.textLabel?.text = itemArray [indexPath.row]
        
        return cell
    }
    
    //MARK - TableView Delegate Methods
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        //TODO: remove this console print
        print(itemArray[indexPath.row])
        
        //Set and remove checklist mark
        if tableView.cellForRow(at: indexPath)?.accessoryType == .checkmark {
           
            tableView.cellForRow(at: indexPath)?.accessoryType = .none
        } else {
            tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
        }
        
        
        //Deselect row to remove the grey highlight for UI beautification purposes
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    //MARK - Other overrides

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

