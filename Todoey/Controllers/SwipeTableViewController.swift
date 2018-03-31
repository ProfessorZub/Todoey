//
//  SwipeTableViewController.swift
//  Todoey
//
//  Created by Miguel Diez on 3/30/18.
//  Copyright © 2018 Professor Z, LLC. All rights reserved.
//

import UIKit
import SwipeCellKit

class SwipeTableViewController: UITableViewController, SwipeTableViewCellDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
         tableView.rowHeight = 80.0
    }
    
    //MARK: - TableView Datasource Methods
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! SwipeTableViewCell
        
        cell.delegate = self
        
        return cell
    }
    
    
    //MARK: - TableView Actions Methods
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath, for orientation: SwipeActionsOrientation) -> [SwipeAction]? {
        
        guard orientation == .right else { return nil }
        
        let deleteAction = SwipeAction(style: .destructive, title: "Delete") { (action, IndexPath) in
            //handle what happens when a left swipe is performed in order to delete
            print("Delete Action Happening")
            self.updateDataModel(at: indexPath)
        }
        //customize the delete action appearance
        deleteAction.image = UIImage(named: "trash-icon")
        return [deleteAction]
    }
    
    func tableView(_ tableView: UITableView, editActionsOptionsForRowAt indexPath: IndexPath, for orientation: SwipeActionsOrientation) -> SwipeTableOptions {
        
        var options = SwipeTableOptions()
        options.expansionStyle = .destructive
        return options
    }
    
    //MARK: - Update Data Model Methods
    func updateDataModel(at indexPath: IndexPath) {
        //Nothing to do at the super class level. This is meant to be overriden by the sub-class to work on the relevant data model.
    }
}
