import UIKit
import CoreGraphics

extension UIWindow {
    var devicePixelRatio:CGFloat {
        get {
            return 1
        }
    }
}

struct JSColor {
    let r:CGFloat,g:CGFloat,b:CGFloat
    init(hex:Int) {
        r = CGFloat((hex >> 16) & 0xFF)
        g = CGFloat((hex >> 8) & 0xFF)
        b = CGFloat((hex) & 0xFF)
    }
    init(_ colors:[Int]) {
        r = CGFloat(colors[0]) / 255.0
        g = CGFloat(colors[1]) / 255.0
        b = CGFloat(colors[2]) / 255.0
    }
    var color: UIColor {
        return UIColor(red: r, green: g, blue:b, alpha: 1.0)
    }
    var hex : Int {
        return (Int(r) << 16) + Int(g) << 8 + Int(b)
    }
    var cgColor: CGColor {
        return color.CGColor
    }
}

extension UIColor {
    convenience init(hex:Int, alpha:Float = 1.0) {
        let r = Float((hex >> 16) & 0xFF)
        let g = Float((hex >> 8) & 0xFF)
        let b = Float((hex) & 0xFF)
        self.init(red: CGFloat(r / 255.0), green: CGFloat(g / 255.0), blue:CGFloat(b / 255.0), alpha: CGFloat(alpha))
    }
}


