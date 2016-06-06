//
//  ItemTextField.swift
//  Homepwner
//
//  Created by Derek Gilwa on 6/6/16.
//  Copyright © 2016 gliwaderek.com. All rights reserved.
//

import UIKit

class ItemTextField: UITextField {
    
    override func becomeFirstResponder() -> Bool {
        borderStyle = .None
        return super.becomeFirstResponder()
    }
    
    override func resignFirstResponder() -> Bool {
        borderStyle = .RoundedRect
        return super.resignFirstResponder()
    }
}
