//
//  DatePickerController.swift
//  Homepwner
//
//  Created by Derek Gilwa on 6/6/16.
//  Copyright © 2016 gliwaderek.com. All rights reserved.
//

import UIKit

class DatePickerController: UIViewController {
    var item: Item!
    var dateFormatter: NSDateFormatter!

    @IBOutlet var datePicker: UIDatePicker!
    @IBOutlet var itemDate: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()

        itemDate.text = dateFormatter.stringFromDate(item.dateCreated)
    }

    @IBAction func dateChanged(sender: AnyObject) {
        item.dateCreated = datePicker.date
        itemDate.text = dateFormatter.stringFromDate(item.dateCreated)
    }

}
