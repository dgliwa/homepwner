//
//  ItemStore.swift
//  Homepwner
//
//  Created by Derek Gilwa on 5/15/16.
//  Copyright © 2016 gliwaderek.com. All rights reserved.
//

import UIKit

class ItemStore {
    
    var allItems = [Item]()
    
    func createItem() -> Item {
        let newItem = Item(random: true)
        
        allItems.append(newItem)
        
        return newItem
    }
}
