//
//  DetailViewController.swift
//  BigNerdRanchHomepwner
//
//  Created by 10.12 on 2018/9/5.
//  Copyright © 2018 10.12. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController, UITextFieldDelegate, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
    // MARK: Outlets
    @IBOutlet var nameField: UITextField!
    @IBOutlet var serialNumberField: UITextField!
    @IBOutlet var valueField: UITextField!
    @IBOutlet var dateLabel: UILabel!
    @IBOutlet var imageView: UIImageView!
    // MARK: Properties
    var item: Item! {
        didSet {
            navigationItem.title = item.name
        }
    }
    var imageStore: ImageStore!
    
    let numberFormatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.minimumFractionDigits = 2
        formatter.maximumFractionDigits = 2
        return formatter
    }()
    
    let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .none
        return formatter
    }()
    
    // MARK: Life cycle
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        nameField.text = item.name
        serialNumberField.text = item.serialNumber
        valueField.text = numberFormatter.string(from: item.valueInDollars as NSNumber)
        dateLabel.text = dateFormatter.string(from: item.dateCreated as Date)
        
        // Get the item key
        let key = item.itemKey
        // If there is an associated image with the item, display it on the imageView
        let imageToDisplay = imageStore.imageForKey(key: key)
        imageView.image = imageToDisplay
        
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // Clear first responder: hide the keyboard
        view.endEditing(true)
        // "Save" changes to item
        item.name = nameField.text ?? ""
        item.serialNumber = serialNumberField.text
        
        if let valueText = valueField.text, let value = numberFormatter.number(from: valueText){
            item.valueInDollars = value.intValue
        } else {
            item.valueInDollars = 0
        }
    }
    
    // MARK: Hide keyboard: use return
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    // MARK: Hide keyboard: tap anywhere
    @IBAction func backgroundTapped(_ sender: UITapGestureRecognizer) {
        view.endEditing(true)
    }
    
    // MARK: Action: take picture
    @IBAction func takePicture(_ sender: UIBarButtonItem) {
        let imagePicker = UIImagePickerController()
        
        // if the device has a camera, take a picture;
        // otherwise, just pick from photo library
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            imagePicker.sourceType = .camera
        } else {
            imagePicker.sourceType = .photoLibrary
        }
        
        // Set imagePicker's delegate as DetailViewController
        imagePicker.delegate = self
        // Place image picker on the screen
        present(imagePicker, animated: true, completion: nil)
    }
    // put image in the UIImageView & hide UIImagePickerController
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        // Get picked image from info dictionary
        let image = info[UIImagePickerController.InfoKey.originalImage] as! UIImage
        
        // Store the image in the ImageStore for the item's key
        imageStore.setImage(image: image, forKey: item.itemKey)
        
        // Put the image on the screen in the imageView
        imageView.image = image
        
        // Take image picker off the screen, call the dismiss method
        dismiss(animated: true, completion: nil)
        
    }
}
