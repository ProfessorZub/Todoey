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
    }
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath, for orientation: SwipeActionsOrientation) -> [SwipeAction]? {
        
        guard orientation == .right else { return nil }
        
        let deleteAction = SwipeAction(style: .destructive, title: "Delete") { (action, IndexPath) in
            //handle what happens when a left swipe is performed in order to delete
            print("Delete Action Happening")
//            if let categoryForDeletion = self.categories?[indexPath.row] {
//                do {
//                    try self.realm.write {
//                        self.realm.delete(categoryForDeletion)
//                    }
//                }
//                catch {
//                    print("Error deleting category from realm: \(error)")
//                }
//                //                tableView.reloadData()    //not needed after implementing SwipeTableOptions with exapansionStyle destruvtive since that already causes the table to refresh.
//            }
            //This implementation force unwraps the category and is not ideal
            //            do {
            //                try self.realm.write {
            //                    self.realm.delete((self.categories?[indexPath.row])!)
            //                }
            //            } catch {
            //                print("Error deleting category from realm: \(error)")
            //                }
        }
        //customize the delete action appearance
        deleteAction.image = UIImage(named: "delete-icon")
        return [deleteAction]
    }
    
    func tableView(_ tableView: UITableView, editActionsOptionsForRowAt indexPath: IndexPath, for orientation: SwipeActionsOrientation) -> SwipeTableOptions {
        
        var options = SwipeTableOptions()
        options.expansionStyle = .destructive
        return options
    }
}
