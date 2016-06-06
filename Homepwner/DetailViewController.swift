//
//  DetailViewController.swift
//  Homepwner
//
//  Created by Derek Gilwa on 6/1/16.
//  Copyright © 2016 gliwaderek.com. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController, UITextFieldDelegate, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
    @IBOutlet var serialField: ItemTextField!
    @IBOutlet var nameField: ItemTextField!
    @IBOutlet var valueField: ItemTextField!
    @IBOutlet var date: UILabel!
    @IBOutlet var imageView: UIImageView!
    
    var imageStore: ImageStore!
    
    var item: Item! {
        didSet {
            navigationItem.title = item.name
        }
    }

    @IBAction func takePicture(sender: UIBarButtonItem) {
        let imagePicker = UIImagePickerController()
        
        if UIImagePickerController.isSourceTypeAvailable(.Camera) {
            imagePicker.sourceType = .Camera
        } else {
            imagePicker.sourceType = .PhotoLibrary
        }
        
        imagePicker.delegate = self
        
        presentViewController(imagePicker, animated: true, completion: nil)
    }

    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String: AnyObject]) {
        
        let image = info[UIImagePickerControllerOriginalImage] as! UIImage
        imageView.image = image
        imageStore.setImage(image, forKey: item.itemKey)
        
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func backgroundTapped(sender: AnyObject) {
        view.endEditing(true)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "ChooseDate" {
            let chooseDateController = segue.destinationViewController as! DatePickerController
            chooseDateController.item = item
            chooseDateController.dateFormatter = dateFormatter
        }
    }

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        nameField.text = item.name
        valueField.text = numberFormatter.stringFromNumber(item.valueInDollars)
        serialField.text = item.serialNumber
        date.text = dateFormatter.stringFromDate(item.dateCreated)
        imageView.image = imageStore.imageForKey(item.itemKey)
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        
        view.endEditing(true)
        item.name = nameField.text ?? ""
        item.serialNumber = serialField.text
        if let valueText = valueField.text, value = numberFormatter.numberFromString(valueText) {
            item.valueInDollars = value.integerValue
        } else {
            item.valueInDollars = 0
        }
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    let numberFormatter: NSNumberFormatter = {
        let formatter = NSNumberFormatter()
        formatter.numberStyle = .DecimalStyle
        formatter.minimumFractionDigits = 2
        formatter.maximumFractionDigits = 2
        return formatter
    }()
    
    let dateFormatter: NSDateFormatter = {
        let formatter = NSDateFormatter()
        formatter.dateStyle = .MediumStyle
        formatter.timeStyle = .NoStyle
        return formatter
    }()
}
