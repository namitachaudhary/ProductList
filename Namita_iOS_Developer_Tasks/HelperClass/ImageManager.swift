//
//  ProductListVC.swift
//  Namita_iOS_Developer_Tasks
//
//  Created by Admin on 13/03/23.
//
import Foundation
import UIKit


class ImageManager {
    
    let imageCache = NSCache<AnyObject,AnyObject>()
    
    func getImageFrom(url: URL, completion: @escaping (UIImage?,String? ) -> Void) {
        if let image = imageForKey(key: url.absoluteString) {
            completion(image, url.absoluteString)
        } else {
            ImageRequestManager.shared.getImageData(thumbnailURL: URLRequest(url: url)) { [weak self] imageData, error in
                self?.saveImageInCache(image: UIImage(data: imageData!), forkey: url.absoluteString)
                completion(imageData != nil ? UIImage(data: imageData!) : nil, url.absoluteString)
            }
        }
        
    }
    
    func saveImageInCache(image: UIImage?, forkey key: String) {
        if let image = image {
            imageCache.setObject(image, forKey: key as AnyObject)
            
            let imageURL = imageURLForKey(key: key)
            if let data = image.jpegData(compressionQuality: 0.5) {
                try? data.write(to: imageURL, options: .atomicWrite)
            }
        }
    }
    
    func imageForKey(key: String) -> UIImage? {
        if let existingImage = imageCache.object(forKey: key as AnyObject) as? UIImage {
            return existingImage
        }
        
        let imageURL = imageURLForKey(key: key)
        guard let imageFromDisk = UIImage(contentsOfFile: imageURL.path) else {
            return nil
        }
        
        imageCache.setObject(imageFromDisk, forKey: key as AnyObject)
        return imageFromDisk
    }
    
    func imageURLForKey(key: String) -> URL {
        let documentsDirectories = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let documentDirectory = documentsDirectories.first!
        return documentDirectory.appendingPathComponent(key)
    }
}
