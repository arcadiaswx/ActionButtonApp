//
//  Notification.swift
//  ActionButtonApp
//
//  Created by teklabsco on 12/22/15.
//  Copyright © 2015 Teklabs, LLC. All rights reserved.
//
/*
import Foundation
import RealmSwift

/**
 Represents the single portion. Multiple portions will be recorded throughout the day (Entry)
 */
public class Notification: Object {
    dynamic var date = NSDate()
    dynamic var quantity = 0.0
    dynamic var title = "NEW_TITLE"
    
    public convenience init(title: String, quantity: Double) {
        self.init()
        self.title = title
        self.quantity = quantity
    }
}
*/
import Foundation

class Notification: PrayerBase {
    var imageUrl:String!
    var htmlUrl:String!
    var imageData: NSData?
    
    var notificationName = ""
    var designerName = ""
    var avatarUrl = ""
    var shotCount = 0
    
    override init(data: NSDictionary) {
        super.init(data: data)
        
        let images = data["images"] as! NSDictionary
        self.imageUrl = Utility.getStringFromJSON(images, key: "normal")
        self.htmlUrl = data["html_url"] as! String
        
        notificationName = data["title"] as! String
        let user = data["user"] as! NSDictionary
        designerName = Utility.getStringFromJSON(user, key: "name")
        avatarUrl = Utility.getStringFromJSON(user, key: "avatar_url")
        shotCount = data["views_count"] as! Int
    }
}
