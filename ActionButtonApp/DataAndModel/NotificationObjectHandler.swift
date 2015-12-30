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

class NotificationObjectHandler {
    
    class func asyncLoadNotificationImage(notification: Notification, imageView: UIImageView){
        let downloadQueue = dispatch_queue_create("com.teklabsco.processdownload", nil)
        
        dispatch_async(downloadQueue){
            let data = NSData(contentsOfURL: NSURL(string: notification.imageUrl)!)
            
            var image: UIImage?
//            var sdImageView: UIImageView?
          
            if data != nil {
                notification.imageData = data
                image = UIImage(data: data!)!
            }
            
//            imageView.sd_setImageWithURL(NSURL(string: notification.imageUrl)!)
            
            dispatch_async(dispatch_get_main_queue()){
                imageView.image = image
            }
        }
    }
    
    class func getNotifications(url: String, callback:(([Notification]) -> Void)){
        var notifications = [Notification]()
        let url = url + "&access_token=" + Config.ACCESS_TOKEN
        
        HttpService.getJSON(url){ (jsonData) -> Void in
            
            for notificationData in jsonData {
                let notification = Notification(data: notificationData as! NSDictionary)
                notifications.append(notification)
            }
            
            let priority = DISPATCH_QUEUE_PRIORITY_DEFAULT
            dispatch_async(dispatch_get_global_queue(priority, 0), { () -> Void in
                dispatch_async(dispatch_get_main_queue(), { () -> Void in
                    callback(notifications)
                })
            })
        }
    }
}