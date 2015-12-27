//
//  PrayerBase.swift

//

//

import Foundation

class PrayerBase {
    var id: Int
    
    init(data: NSDictionary){
        self.id = data["id"] as! Int
    }
}
