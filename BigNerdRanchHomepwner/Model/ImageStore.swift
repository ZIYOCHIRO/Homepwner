//
//  ImageStore.swift
//  BigNerdRanchHomepwner
//
//  Created by 10.12 on 2018/9/5.
//  Copyright © 2018 10.12. All rights reserved.
//

import Foundation
import UIKit

class ImageStore {
    let cache = NSCache<NSString, UIImage>()
    
    // get imageURL by image's key
    func imageURL(forKey key: String) -> URL {
        let documentsDirectories = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let documentDirecotry = documentsDirectories.first!
        return documentDirecotry.appendingPathComponent(key)
    }
    
    // Add image  &&  save image data by NSData
    func setImage(image: UIImage, forKey key:String) {
        cache.setObject(image, forKey: key as NSString)
        
        // Creat full URL for image
        let imageurl = imageURL(forKey: key)
        
        // Turn image into JPEG data
        if let data = image.jpegData(compressionQuality: 0.5) {
            // write it to full URL
            let _ = try? data.write(to: imageurl, options: [.atomic])
        }
        
    }
    // Get image for key
    func image(forKey key: String) -> UIImage? {
        if let existingImage = cache.object(forKey: key as NSString) {
            return existingImage
        }
        let imageurl = imageURL(forKey: key)
        guard let imageFromDisk = UIImage(contentsOfFile: imageurl.path) else {
            return nil
        }
        cache.setObject(imageFromDisk, forKey: key as NSString)
        return imageFromDisk
    }
    // Delete image
    func deleteImageForKey(key: String) {
        cache.removeObject(forKey: key as NSString)
        
        let imageurl = imageURL(forKey: key)
        do {
           try FileManager.default.removeItem(at: imageurl)
        } catch let deleteError {
            print("Error removing the item from disk: \(deleteError)")
        }
    }
}
