import Foundation
import Parse

final class Cache {
    private var cache: NSCache

    // MARK:- Initialization
    
    static let sharedCache = Cache()

    private init() {
        self.cache = NSCache()
    }

    // MARK:- Cache

    func clear() {
        cache.removeAllObjects()
    }

    func setAttributesForPhoto(photo: PFObject, likers: [PFUser], commenters: [PFUser], likedByCurrentUser: Bool) {
        let attributes = [
            kPhotoAttributesIsLikedByCurrentUserKey: likedByCurrentUser,
            kPhotoAttributesLikeCountKey: likers.count,
            kPhotoAttributesLikersKey: likers,
            kPhotoAttributesCommentCountKey: commenters.count,
            kPhotoAttributesCommentersKey: commenters
        ]
        setAttributes(attributes as! [String : AnyObject], forPhoto: photo)
    }

    
    func setAttributesForPrayer(prayer: PFObject, likers: [PFUser], commenters: [PFUser], likedByCurrentUser: Bool) {
        let attributes = [
            kPrayerAttributesIsLikedByCurrentUserKey: likedByCurrentUser,
            kPrayerAttributesLikeCountKey: likers.count,
            kPrayerAttributesLikersKey: likers,
            kPrayerAttributesCommentCountKey: commenters.count,
            kPrayerAttributesCommentersKey: commenters
        ]
        setAttributes(attributes as! [String : AnyObject], forPrayer: prayer)
    }
    
    func attributesForPhoto(photo: PFObject) -> [String:AnyObject]? {
        let key: String = self.keyForPhoto(photo)
        return cache.objectForKey(key) as? [String:AnyObject]
    }

    func attributesForPrayer(prayer: PFObject) -> [String:AnyObject]? {
        let key: String = self.keyForPrayer(prayer)
        return cache.objectForKey(key) as? [String:AnyObject]
    }
    
    func likeCountForPhoto(photo: PFObject) -> Int {
        let attributes: [NSObject:AnyObject]? = self.attributesForPhoto(photo)
        if attributes != nil {
            return attributes![kPhotoAttributesLikeCountKey] as! Int
        }

        return 0
    }

    func likeCountForPrayer(prayer: PFObject) -> Int {
        let attributes: [NSObject:AnyObject]? = self.attributesForPrayer(prayer)
        if attributes != nil {
            return attributes![kPrayerAttributesLikeCountKey] as! Int
        }
        
        return 0
    }
    
    func commentCountForPhoto(photo: PFObject) -> Int {
        let attributes = attributesForPhoto(photo)
        if attributes != nil {
            return attributes![kPhotoAttributesCommentCountKey] as! Int
        }
        
        return 0
    }

    func commentCountForPrayer(prayer: PFObject) -> Int {
        let attributes = attributesForPrayer(prayer)
        if attributes != nil {
            return attributes![kPrayerAttributesCommentCountKey] as! Int
        }
        
        return 0
    }
    
    func likersForPhoto(photo: PFObject) -> [PFUser] {
        let attributes = attributesForPhoto(photo)
        if attributes != nil {
            return attributes![kPhotoAttributesLikersKey] as! [PFUser]
        }
        
        return [PFUser]()
    }

    func likersForPrayer(prayer: PFObject) -> [PFUser] {
        let attributes = attributesForPrayer(prayer)
        if attributes != nil {
            return attributes![kPrayerAttributesLikersKey] as! [PFUser]
        }
        
        return [PFUser]()
    }
    
    func commentersForPhoto(photo: PFObject) -> [PFUser] {
        let attributes = attributesForPhoto(photo)
        if attributes != nil {
            return attributes![kPhotoAttributesCommentersKey] as! [PFUser]
        }
        
        return [PFUser]()
    }

    func commentersForPrayer(prayer: PFObject) -> [PFUser] {
        let attributes = attributesForPrayer(prayer)
        if attributes != nil {
            return attributes![kPrayerAttributesCommentersKey] as! [PFUser]
        }
        
        return [PFUser]()
    }
    
    func setPhotoIsLikedByCurrentUser(photo: PFObject, liked: Bool) {
        var attributes = attributesForPhoto(photo)
        attributes![kPhotoAttributesIsLikedByCurrentUserKey] = liked
        setAttributes(attributes!, forPhoto: photo)
    }

    func setPrayerIsLikedByCurrentUser(prayer: PFObject, liked: Bool) {
        var attributes = attributesForPhoto(prayer)
        attributes![kPrayerAttributesIsLikedByCurrentUserKey] = liked
        setAttributes(attributes!, forPrayer: prayer)
    }
    
    func isPhotoLikedByCurrentUser(photo: PFObject) -> Bool {
        let attributes = attributesForPhoto(photo)
        if attributes != nil {
            return attributes![kPhotoAttributesIsLikedByCurrentUserKey] as! Bool
        }
        
        return false
    }

    func isPrayerLikedByCurrentUser(prayer: PFObject) -> Bool {
        let attributes = attributesForPhoto(prayer)
        if attributes != nil {
            return attributes![kPrayerAttributesIsLikedByCurrentUserKey] as! Bool
        }
        
        return false
    }
    
    func incrementLikerCountForPhoto(photo: PFObject) {
        let likerCount = likeCountForPhoto(photo) + 1
        var attributes = attributesForPhoto(photo)
        attributes![kPhotoAttributesLikeCountKey] = likerCount
        setAttributes(attributes!, forPhoto: photo)
    }

    func decrementLikerCountForPhoto(photo: PFObject) {
        let likerCount = likeCountForPhoto(photo) - 1
        if likerCount < 0 {
            return
        }
        var attributes = attributesForPhoto(photo)
        attributes![kPhotoAttributesLikeCountKey] = likerCount
        setAttributes(attributes!, forPhoto: photo)
    }
    
    func incrementLikerCountForPrayer(prayer: PFObject) {
        let likerCount = likeCountForPrayer(prayer) + 1
        var attributes = attributesForPrayer(prayer)
        attributes![kPrayerAttributesLikeCountKey] = likerCount
        setAttributes(attributes!, forPhoto: prayer)
    }
    
    func decrementLikerCountForPrayer(prayer: PFObject) {
        let likerCount = likeCountForPrayer(prayer) - 1
        if likerCount < 0 {
            return
        }
        var attributes = attributesForPrayer(prayer)
        attributes![kPrayerAttributesLikeCountKey] = likerCount
        setAttributes(attributes!, forPrayer: prayer)
    }
    
    func incrementCommentCountForPhoto(photo: PFObject) {
        let commentCount = commentCountForPhoto(photo) + 1
        var attributes = attributesForPhoto(photo)
        attributes![kPhotoAttributesCommentCountKey] = commentCount
        setAttributes(attributes!, forPhoto: photo)
    }

    func decrementCommentCountForPhoto(photo: PFObject) {
        let commentCount = commentCountForPhoto(photo) - 1
        if commentCount < 0 {
            return
        }
        var attributes = attributesForPhoto(photo)
        attributes![kPhotoAttributesCommentCountKey] = commentCount
        setAttributes(attributes!, forPhoto: photo)
    }

    func incrementCommentCountForPrayer(prayer: PFObject) {
        let commentCount = commentCountForPrayer(prayer) + 1
        var attributes = attributesForPrayer(prayer)
        attributes![kPrayerAttributesCommentCountKey] = commentCount
        setAttributes(attributes!, forPrayer: prayer)
    }
    
    func decrementCommentCountForPrayer(prayer: PFObject) {
        let commentCount = commentCountForPhoto(prayer) - 1
        if commentCount < 0 {
            return
        }
        var attributes = attributesForPrayer(prayer)
        attributes![kPrayerAttributesCommentCountKey] = commentCount
        setAttributes(attributes!, forPrayer: prayer)
    }
    
    func setAttributesForUser(user: PFUser, photoCount count: Int, followedByCurrentUser following: Bool) {
        let attributes = [
            kUserAttributesPhotoCountKey: count,
            kUserAttributesIsFollowedByCurrentUserKey: following
        ]

        setAttributes(attributes as! [String : AnyObject], forUser: user)
    }

    func attributesForUser(user: PFUser) -> [String:AnyObject]? {
        let key = keyForUser(user)
        return cache.objectForKey(key) as? [String:AnyObject]
    }

    func photoCountForUser(user: PFUser) -> Int {
        if let attributes = attributesForUser(user) {
            if let photoCount = attributes[kUserAttributesPhotoCountKey] as? Int {
                return photoCount
            }
        }
        
        return 0
    }

    func followStatusForUser(user: PFUser) -> Bool {
        if let attributes = attributesForUser(user) {
            if let followStatus = attributes[kUserAttributesIsFollowedByCurrentUserKey] as? Bool {
                return followStatus
            }
        }

        return false
    }

    func setPhotoCount(count: Int,  user: PFUser) {
        if var attributes = attributesForUser(user) {
            attributes[kUserAttributesPhotoCountKey] = count
            setAttributes(attributes, forUser: user)
        }
    }

    func setFollowStatus(following: Bool, user: PFUser) {
        if var attributes = attributesForUser(user) {
            attributes[kUserAttributesIsFollowedByCurrentUserKey] = following
            setAttributes(attributes, forUser: user)
        }
    }

    func setFacebookFriends(friends: NSArray) {
        let key: String = kUserDefaultsCacheFacebookFriendsKey
        self.cache.setObject(friends, forKey: key)
        NSUserDefaults.standardUserDefaults().setObject(friends, forKey: key)
        NSUserDefaults.standardUserDefaults().synchronize()
    }

    func facebookFriends() -> [PFUser] {
        let key = kUserDefaultsCacheFacebookFriendsKey
        if cache.objectForKey(key) != nil {
            return cache.objectForKey(key) as! [PFUser]
        }
        
        let friends = NSUserDefaults.standardUserDefaults().objectForKey(key)
        if friends != nil {
            cache.setObject(friends!, forKey: key)
            return friends as! [PFUser]
        }
        return [PFUser]()
    }

    // MARK:- ()

    func setAttributes(attributes: [String:AnyObject], forPhoto photo: PFObject) {
        let key: String = self.keyForPhoto(photo)
        cache.setObject(attributes, forKey: key)
    }

    func setAttributes(attributes: [String:AnyObject], forPrayer prayer: PFObject) {
        let key: String = self.keyForPrayer(prayer)
        cache.setObject(attributes, forKey: key)
    }
    
    func setAttributes(attributes: [String:AnyObject], forUser user: PFUser) {
        let key: String = self.keyForUser(user)
        cache.setObject(attributes, forKey: key)
    }

    func keyForPhoto(photo: PFObject) -> String {
        return "photo_\(photo.objectId)"
    }

    func keyForPrayer(prayer: PFObject) -> String {
        return "prayer_\(prayer.objectId)"
    }
    
    func keyForUser(user: PFUser) -> String {
        return "user_\(user.objectId)"
    }
}
