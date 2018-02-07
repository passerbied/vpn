
 
import Foundation
import UIKit

let k_Bugly_App_ID = "i1400011872"
let k_UM_AppKey = "57c0f93267e58eaeab00156d"

let k_WX_AppID = "wx7f5bd6d49981e6be"
let k_WX_AppSecret = "ec8f6aaf727edfd452b2dd74d80b05db"

let k_NotificationID = "notificationID"

let k_Service = "com.hitalkie"
let k_Token = "token"
let k_UserID = "user_id"

// MARK: 尺寸
let k_PADDING : CGFloat = 10.0*k_SCREEN_SCALE
let k_SCREEN_W = UIScreen.main.bounds.size.width
let k_SCREEN_H = UIScreen.main.bounds.size.height
let k_SCREEN_SCALE = UIScreen.main.bounds.size.width/375
let k_STATUS_BAR_H = UIApplication.shared.statusBarFrame.height
let k_TAB_BAR_H : CGFloat = 49.0
let k_NAV_BAR_H : CGFloat = 64.0
let k_IS_IPHONE_4_SCREEN = fabs(Double(UIScreen.main.bounds.size.height)-Double(480)) < Double.ulpOfOne

let k_AppDelegate: AppDelegate = UIApplication.shared.delegate as! AppDelegate

// MARK: key window
let k_KEY_WINDOW = UIApplication.shared.keyWindow

// MARK: 快捷方法
func kURL (_ url : String = "") ->Foundation.URL {
    if Foundation.URL(string: url) != nil {
        return Foundation.URL(string: url)!
    }
    return Foundation.URL(string: "www.baidu.com")!
}

func IMG (_ imgName : String) ->UIImage {
    if UIImage(named: imgName) != nil {
        return UIImage(named: imgName)!
    }
    return UIImage()
}

func UIColorFromRGB(_ rgbValue: UInt) -> UIColor {
    return UIColor(
        red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
        green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
        blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
        alpha: CGFloat(1.0)
    )
}

func UIColorFromSRGB(_ srgbValue: UInt, _ alpha : CGFloat?) -> UIColor {
    var a: CGFloat = 1.0
    if alpha != nil {
        a = alpha!
    }
    if #available(iOS 10.0, *) {
        return UIColor(
            displayP3Red: CGFloat((srgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((srgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(srgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(a)
        )
    }
    return UIColorFromRGBA(srgbValue, alpha: a)
}

func UIColorFromRGBA(_ rgbValue: UInt,alpha : CGFloat) -> UIColor {
    return UIColor(
        red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
        green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
        blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
        alpha: CGFloat(alpha)
    )
}

func HS_FONT (_ size:CGFloat) -> UIFont {
    return UIFont.systemFont(ofSize: size)
}

func B_FONT (_ size:CGFloat) -> UIFont {
    return UIFont.boldSystemFont(ofSize: size)
}

func R_FONT (_ size:CGFloat) -> UIFont {
    return UIFont.systemFont(ofSize: size)
}

func WAWATI_FONT (_ size:CGFloat) -> UIFont {
    if UIFont.init(name: "DFPWaWaW5", size: size) != nil {
        return UIFont.init(name: "DFPWaWaW5", size: size)!
    } else {
        return HS_FONT(size)
    }
}


func ccr(_ x:CGFloat, _ y:CGFloat,_ width:CGFloat,_ height:CGFloat) ->CGRect{
    return CGRect(x: x, y: y, width: width, height: height)
}

func ccs(_ width:CGFloat,_ height:CGFloat) ->CGSize{
    return CGSize(width: width, height: height)
}


func ccp(_ x:CGFloat,_ y:CGFloat) ->CGPoint{
    return CGPoint(x: x, y: y)
}

fileprivate func < <T : Comparable>(lhs: T?, rhs: T?) -> Bool {
    switch (lhs, rhs) {
    case let (l?, r?):
        return l < r
    case (nil, _?):
        return true
    default:
        return false
    }
}

fileprivate func > <T : Comparable>(lhs: T?, rhs: T?) -> Bool {
    switch (lhs, rhs) {
    case let (l?, r?):
        return l > r
    default:
        return rhs < lhs
    }
}

let kColor_Red = UIColorFromSRGB(0xfe6555,1)
let kColor_Gray = UIColorFromSRGB(0x666666,1)
let kColor_Black = UIColorFromSRGB(0x000000,1)
let kColor_White = UIColorFromSRGB(0xffffff,1)
let kColor_Background = UIColorFromSRGB(0xf5f5f5,1)
let kColor_PlaceHolder = UIColorFromSRGB(0xa0a0a0,1)
let kColor_Yellow = UIColorFromSRGB(0xf9e900,1)
let kColor_Button_Border_Gray = UIColorFromSRGB(0xf4f4f4,1)
let kColor_Red_Disable = UIColorFromSRGB(0xff9e9f,1)
let kColor_Separator = UIColorFromSRGB(0xe6e6e6,1)
