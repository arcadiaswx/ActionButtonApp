/*
import Foundation
import RealmSwift

/**
Represents the single portion. Multiple portions will be recorded throughout the day (Entry)
*/
public class Prayer: Object {
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

class Prayer: PrayerBase {
    var imageUrl:String!
    var htmlUrl:String!
    var imageData: NSData?
    
    ///var shotName = ""
    var prayerTitle = ""
    var userName = ""
    var avatarUrl = ""
    var shotCount = 0
    
    override init(data: NSDictionary) {
        super.init(data: data)
        
        let images = data["images"] as! NSDictionary
        self.imageUrl = Utility.getStringFromJSON(images, key: "normal")
        self.htmlUrl = data["html_url"] as! String
        
       prayerTitle = data["title"] as! String
        let user = data["user"] as! NSDictionary
        userName = Utility.getStringFromJSON(user, key: "name")
        avatarUrl = Utility.getStringFromJSON(user, key: "avatar_url")
        shotCount = data["views_count"] as! Int
    }
}
