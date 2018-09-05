//
//  ItemsViewController.swift
//  BigNerdRanchHomepwner
//
//  Created by 10.12 on 2018/9/3.
//  Copyright © 2018 10.12. All rights reserved.
//

import UIKit

class ItemsViewController: UITableViewController {
    
    // MARK: Properties
    var itemStore: ItemStore!
    var imageStore: ImageStore!
    
    // MARK: set left BarButtonItem
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        navigationItem.leftBarButtonItem = editButtonItem
    }
    // MARK: Life cycle
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        tableView.reloadData()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 65
    }
    
    // MARK: Two required function
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemStore.allItems.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // Get a new or recycled cell
        let cell = tableView.dequeueReusableCell(withIdentifier: "ItemCell", for: indexPath) as! ItemCell
        
        // Update the labels for the new preferred text size
        cell.updateLabels()
        
        // Set the text on the cell with the description of the item
        // that is at the nth index of items, where n = row this cell
        // will appear in the tableView
        let item = itemStore.allItems[indexPath.row]
        // Config the cell with item
        cell.nameLabel.text = item.name
        cell.serialNumberLabel.text = item.serialNumber
        cell.valueLabel.text = "$ \(item.valueInDollars)"
        return cell
    }
    
    // MARK: Deleting rows and displaying User Alerts
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        // if the table view is asking to commit a delete command
        if editingStyle == .delete {
            let item = itemStore.allItems[indexPath.row]
            
            // Displaying User Alerts
            let title = "Delete \(item.name)"
            let message = "Are you sure you want to delete this item?"
            
            let alertController = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.actionSheet)
            let cancelAction = UIAlertAction(title: "Cancle", style: UIAlertAction.Style.cancel, handler: nil)
            alertController.addAction(cancelAction)
        
            let deleteAction = UIAlertAction(title: "Delete", style: UIAlertAction.Style.destructive) { (action) in
                // remove the item from the itemstore
                self.itemStore.removeItem(item: item)
                // remove the image from the imageStore
                self.imageStore.deleteImageForKey(key: item.itemKey)
                // Also remove that row from the table view with an animation
                self.tableView.deleteRows(at: [indexPath], with: .automatic)
            }
            alertController.addAction(deleteAction)
            
            // Present the alert controller
            present(alertController, animated: true, completion: nil)
            
        }
    }
    // MARK: Moving rows
    override func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        // Update the model
        itemStore.moveItemAtIndex(fromIndex: sourceIndexPath.row, toIndex: destinationIndexPath.row)
    }
    
    // MARK: Acitons
    @IBAction func addNewItem(sender: AnyObject) {
       // Creat a new item and add it to the store
        let newItem = itemStore.creatItem()
        
        // Figure out where that item is in the array
        if let index = itemStore.allItems.lastIndex(of: newItem) {
            let indexPath = NSIndexPath(row: index, section: 0)
            // Insert this new row into the table
            tableView.insertRows(at: [indexPath as IndexPath], with: .automatic)
        }
    }
    
    // MARK: Prepare for segue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowItem" {
            // Figure out which row was just tapped
            if let row = tableView.indexPathForSelectedRow?.row {
                let item = itemStore.allItems[row]
                let detailViewController = segue.destination as! DetailViewController
                detailViewController.item = item
                detailViewController.imageStore = imageStore
            }
        }
    }
}
