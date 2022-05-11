//
//  UIImageView.swift
//  Navi-Problem-Statement
//
//  Created by Lakshay Saini on 11/05/22.
//

import Foundation
import UIKit

extension UIImageView {
    private static var urlStore = [String:String]()
    private static var imageCache=NSCache<AnyObject,UIImage>()
    
    public func imageFromURL(urlString: String, PlaceHolderImage:UIImage? = nil) {
        
        let tmpAddress = String(format: "%p", unsafeBitCast(self, to: Int.self))
        UIImageView.urlStore[tmpAddress] = urlString
        
        if let cachedImage=UIImageView.imageCache.object(forKey: urlString as AnyObject)
        {
            self.image=cachedImage
            return
        }
        
        if let image = PlaceHolderImage {
            self.image = image
        } else{
            self.backgroundColor = .gray
        }
        
        guard let url = URL(string: urlString) else {
            print("failed to get URL in imageFromURL function")
            self.image = UIImage(named: "inf")
            return
        }
        URLSession.shared.dataTask(with: url, completionHandler: { (data, response, error) -> Void in
            
            guard let data = data, error == nil else {
                print("failed to get data from urlsession in imagefromUrl func")
                self.image = UIImage(named: "inf")
                return
            }
            
            DispatchQueue.main.async(execute: { () -> Void in
                if UIImageView.urlStore[tmpAddress] == urlString
                {
                    guard let image = UIImage(data: data) else {
                        print("failed to get image from data in imagefromUrl func")
                        self.image = UIImage(named: "inf")
                        return
                    }
                    self.image = image
                    self.backgroundColor = .clear
                    UIImageView.imageCache.setObject(image, forKey: urlString as AnyObject)
                }
            })
            
        }).resume()
    }
}
