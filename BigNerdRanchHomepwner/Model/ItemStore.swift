//
//  ItemStore.swift
//  BigNerdRanchHomepwner
//
//  Created by 10.12 on 2018/9/3.
//  Copyright © 2018 10.12. All rights reserved.
//

import UIKit
class ItemStore {
    
    // MARK: Properties
    var allItems = [Item]()
    
    // Creat new item and add it to allItems
    func creatItem() -> Item {
        let newItem = Item(random: true)
        allItems.append(newItem)
        return newItem
    }
    // Delete an item from allItems
    func removeItem(item: Item) {
        if let index = allItems.lastIndex(of: item) {
            allItems.remove(at: index)
        }
    }
    // Moving an item
    func moveItemAtIndex(fromIndex: Int, toIndex: Int) {
        if fromIndex == toIndex {
            return
        }
        // Get reference to object being moved so you can re-insert it
        let movedItem = allItems[fromIndex]
        // Remove item from array
        allItems.remove(at: fromIndex)
        // Insert moveditem in array at new locaiton
        allItems.insert(movedItem, at: toIndex)
    }
    
}
