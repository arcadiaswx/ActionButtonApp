import UIKit

typealias Palette = UIColor
extension Palette {
    class func hexStr (var hexStr : NSString, alpha : CGFloat) -> UIColor {
        hexStr = hexStr.stringByReplacingOccurrencesOfString("#", withString: "")
        let scanner = NSScanner(string: hexStr as String)
        var color: UInt32 = 0
        if scanner.scanHexInt(&color) {
            let r = CGFloat((color & 0xFF0000) >> 16) / 255.0
            let g = CGFloat((color & 0x00FF00) >> 8) / 255.0
            let b = CGFloat(color & 0x0000FF) / 255.0
            return UIColor(red:r,green:g,blue:b,alpha:alpha)
        } else {
            print("invalid hex string", terminator: "")
            return UIColor.whiteColor();
        }
    }
    
    class func mainColor() -> UIColor {
        return UIColor(red:0.22, green:0.49, blue:0.81, alpha:1)
    }

    class func confirmColor() -> UIColor {
        return UIColor(red:0.6, green:0.8, blue:0.37, alpha:1)
    }

    class func destructiveColor() -> UIColor {
        return UIColor(red:0.75, green:0.22, blue:0.17, alpha:1)
    }

    class func lightGray() -> UIColor {
        return UIColor(red:0.91, green:0.91, blue:0.92, alpha:1)
    }
    
    class func tabBarBackgroundColor()  -> UIColor {
        return UIColor(red: 0.92, green: 0.96, blue: 0.95, alpha: 1)
    }
    
    class func tabBarSeparatorColor() -> UIColor {
        return UIColor(red: 0.45, green: 0.77, blue: 0.72, alpha: 1)
    }
    
    class func tabBarSelectedItemColor() -> UIColor {
        return UIColor(red: 0.38, green: 0.73, blue: 0.69, alpha: 1)
    }
    
    class func tabBarUnselectedItemColor() -> UIColor {
        return UIColor(red: 0.65, green: 0.74, blue: 0.71, alpha: 1)
    }
    
    class func navigationBarTitleTextColor() -> UIColor {
        return UIColor.hexStr("ffffff", alpha: 1)
    }
    
    class func navigationBarTintColor() -> UIColor {
        return UIColor.hexStr("ffffff", alpha: 1)
    }
    
    class func navigationBarBackgroundColor() -> UIColor {
        //return UIColor.hexStr("EA4C89", alpha: 0.85)
        return UIColor(red:0.22, green:0.49, blue:0.81, alpha:1)
    }
    
    class func scrollMenuBackgroundColor() -> UIColor {
        return UIColor.hexStr("ECEFF1", alpha: 1)
    }
    
    class func viewBackgroundColor() -> UIColor {
        return UIColor.hexStr("263238", alpha: 1)
    }
    
    class func selectionIndicatorColor() -> UIColor {
        return UIColor.hexStr("F06292", alpha: 1)
    }
    
    class func bottomMenuHairlineColor() -> UIColor {
        return UIColor.hexStr("F06292", alpha: 1)
    }
    
    class func selectedMenuItemLabelColor() -> UIColor {
        return UIColor.hexStr("37474F", alpha: 1)
    }
    
    class func unselectedMenuItemLabelColor() -> UIColor {
        return UIColor.hexStr("607D8B", alpha: 1)
    }
    
    class func cellLabelColor() -> UIColor {
        return UIColor.hexStr("546E7A", alpha: 1)
    }

    class func aTLBlueColor() -> UIColor {
        return UIColor(red:0.13, green:0.66, blue:0.88, alpha:1)
        //return UIColor(red:33.0f/255.0f green:170.0f/255.0f blue:225.0f/255.0f alpha:1.0)
    }
}
