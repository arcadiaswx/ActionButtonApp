//
//  DribbbleObjectHandler.swift
//  DribbbleReader
//
//  Created by naoyashiga on 2015/05/17.
//  Copyright (c) 2015年 naoyashiga. All rights reserved.
//

import Foundation
import UIKit
//import WebImage

class PrayerObjectHandler {
    
    class func asyncLoadShotImage(prayer: Prayer, imageView: UIImageView){
        let downloadQueue = dispatch_queue_create("com.naoyashiga.processdownload", nil)
        
        dispatch_async(downloadQueue){
            let data = NSData(contentsOfURL: NSURL(string: prayer.imageUrl)!)
            
            var image: UIImage?
//            var sdImageView: UIImageView?
          
            if data != nil {
                prayer.imageData = data
                image = UIImage(data: data!)!
            }
            
//            imageView.sd_setImageWithURL(NSURL(string: shot.imageUrl)!)
            
            dispatch_async(dispatch_get_main_queue()){
                imageView.image = image
            }
        }
    }
    
    class func getPrayers(url: String, callback:(([Prayer]) -> Void)){
        var prayers = [Prayer]()
        let url = url + "&access_token=" + Config.ACCESS_TOKEN
        
        HttpService.getJSON(url){ (jsonData) -> Void in
            
            for shotData in jsonData {
                let prayer = Prayer(data: shotData as! NSDictionary)
                prayers.append(prayer)
            }
            
            let priority = DISPATCH_QUEUE_PRIORITY_DEFAULT
            dispatch_async(dispatch_get_global_queue(priority, 0), { () -> Void in
                dispatch_async(dispatch_get_main_queue(), { () -> Void in
                    callback(prayers)
                })
            })
        }
    }
}