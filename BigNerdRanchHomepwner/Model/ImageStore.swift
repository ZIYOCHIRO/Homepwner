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
    
    // Add image
    func setImage(image: UIImage, forKey key:String) {
        cache.setObject(image, forKey: key as NSString)
    }
    // Get image
    func imageForKey(key: String) -> UIImage? {
        return cache.object(forKey: key as NSString)
    }
    // Delete image
    func deleteImageForKey(key: String) {
        cache.removeObject(forKey: key as NSString)
    }
}
