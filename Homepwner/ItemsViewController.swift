//
//  ItemsViewController.swift
//  Homepwner
//
//  Created by Derek Gilwa on 5/12/16.
//  Copyright © 2016 gliwaderek.com. All rights reserved.
//

import UIKit

class ItemsViewController: UITableViewController {
    
    var itemStore: ItemStore!
    
    
    @IBAction func addNewItem(sender: AnyObject) {
        let newItem = itemStore.createItem()
        
        if let index = itemStore.allItems.indexOf(newItem) {
            let indexPath = NSIndexPath(forRow: index, inSection: 0)
            tableView.insertRowsAtIndexPaths([indexPath], withRowAnimation: .Automatic)
        }
    }
    
    @IBAction func toggleEditingMode(sender: AnyObject) {
        if editing {
            sender.setTitle("Edit", forState: .Normal)
            setEditing(false, animated: true)
        } else {
            sender.setTitle("Done", forState: .Normal)
            setEditing(true, animated: true)
        }
        
    }
    
    
    override func tableView(tableView: UITableView,
        canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
            if indexPath.section == 0 {
                return true
            }
            return false
    }
    
    override func tableView(tableView: UITableView,
        canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
            if indexPath.section == 0 {
                return true
            }
            return false
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let statusBarHeight = UIApplication.sharedApplication().statusBarFrame.height
        let insets = UIEdgeInsets.init(top: statusBarHeight, left: 0, bottom: 0, right: 0)
        
        tableView.contentInset = insets
        tableView.scrollIndicatorInsets = insets
        
        tableView.estimatedRowHeight = 65
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var numberOfRowsInSection: Int = 0
        switch section {
        case 0: numberOfRowsInSection = itemStore.allItems.count
        case 1: numberOfRowsInSection = 1
        default:
            break
        }
        return numberOfRowsInSection
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 2
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("ItemCell", forIndexPath: indexPath) as! ItemCell
        if indexPath.section == 0 {
            let item = itemStore.allItems[indexPath.row]
            cell.nameLabel?.text = item.name
            cell.nameLabel?.font = cell.textLabel?.font.fontWithSize(20)
            cell.serialNumberLabel?.text = item.serialNumber
            cell.valueLabel?.text = "$\(item.valueInDollars)"
            
        } else {
            cell.nameLabel?.text = "No more items!"
            cell.serialNumberLabel?.text = ""
            cell.valueLabel?.text = ""
        }
        return cell
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if indexPath.section == 1 {
            return 40
        } else {
            return 65
        }
    }
    
    override func tableView(tableView: UITableView, moveRowAtIndexPath sourceIndexPath: NSIndexPath, toIndexPath destinationIndexPath: NSIndexPath) {
        itemStore.moveItemAtIndex(sourceIndexPath.row, toIndex: destinationIndexPath.row)
    }
    
    override func tableView(tableView: UITableView, targetIndexPathForMoveFromRowAtIndexPath sourceIndexPath: NSIndexPath, toProposedIndexPath destinationIndexPath: NSIndexPath) -> NSIndexPath {
        if(destinationIndexPath.section == sourceIndexPath.section) {
            itemStore.moveItemAtIndex(sourceIndexPath.row, toIndex: destinationIndexPath.row)
            return destinationIndexPath
        }
        return sourceIndexPath
    }
    
    
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            let item = itemStore.allItems[indexPath.row]
            
            let title = "Delete \(item.name)?"
            let message = "Are you sure you want to delete this item?"
            
            let ac = UIAlertController(title: title, message: message, preferredStyle: .ActionSheet)
            let cancelAction = UIAlertAction(title: "Cancel", style: .Cancel, handler: nil)
            ac.addAction(cancelAction)
            
            let deleteAction = UIAlertAction(title: "Delete", style: .Destructive, handler: { (action) ->
                Void in
                    self.itemStore.removeItem(item)
                    self.tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Automatic)
            })
            ac.addAction(deleteAction)
            
            presentViewController(ac, animated: true, completion: nil)
        }
    }
}
