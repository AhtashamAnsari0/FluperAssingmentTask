//
//  ImageLoader.swift
//  FluperTask
//
//  Created by Ahtasham Ansari on 10/05/20.
//  Copyright © 2020 AhtashamAnsari. All rights reserved.
//

import Foundation
import UIKit

class LoadImage {
    
    private var cache = NSCache<AnyObject, AnyObject>()
    
    class var sharedLoader : LoadImage {
        struct Static {
            static let instance : LoadImage = LoadImage()
        }
        return Static.instance
    }
    
    func imageFromUrl(urlString: String, completionHandler:@escaping (_ image: UIImage?, _ url: String) -> ()) {
        DispatchQueue.main.async(execute:  {()in
            
            let data = self.cache.object(forKey: urlString as AnyObject) as? Data
            
            if let goodData = data {
                let image = UIImage(data: goodData as Data)
                DispatchQueue.main.async(execute:  {()in
                    
                    completionHandler(image, urlString)
                })
                return
            }
            let downloadTask:URLSessionDataTask = URLSession.shared.dataTask(with: URL(string: urlString)!, completionHandler: {(data, response, error) in
                
                if (error != nil) {
                    completionHandler(nil, urlString)
                    return
                }
                
                if data != nil {
                    let image = UIImage(data: data!)
                    self.cache.setObject(data! as AnyObject, forKey: urlString as AnyObject)
                    DispatchQueue.main.async(execute:  {()in
                        completionHandler(image, urlString)
                    })
                    return
                }
            })
            
            downloadTask.resume()
        })
        
    }
}
