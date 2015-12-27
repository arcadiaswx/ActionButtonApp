//
//  PrayerNotificationBase.swift

//
//  Created by Craig Booker on 2015/12/23.
//  Copyright (c) 2015-2016 Teklabs, LLC. All rights reserved.
//

import Foundation

class PrayerNotificationBase {
    var id: Int
    
    init(data: NSDictionary){
        self.id = data["id"] as! Int
    }
}
