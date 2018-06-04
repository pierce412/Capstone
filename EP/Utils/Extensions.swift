//  Extensions.swift
import UIKit
extension UIColor {
    static func rgb(red: CGFloat, green: CGFloat, blue: CGFloat) -> UIColor {
        return UIColor(red: red/255, green: green/255, blue: blue/255, alpha: 1)
    }
//    static func epYellow() -> UIColor {
//        return UIColor(red: 253.0/255.0, green: 255.0/255.0, blue: 130.0/255.0, alpha: 1.0)
//    }
//    static func epComplement() -> UIColor {
//        return UIColor(red: 132.0/255.0, green: 130.0/255.0, blue: 255.0/255.0, alpha: 1.0)
//    }
    static func buttonDisabled() -> UIColor {
        return UIColor(red: 132.0/255.0, green: 130.0/255.0, blue: 255.0/255.0, alpha: 1.0)
    }
    static func buttonEnabled() -> UIColor {
        return UIColor(red: 132.0/255.0, green: 130.0/255.0, blue: 255.0/255.0, alpha: 1.0)
    }
    static func offWhite() -> UIColor {
        return UIColor(red: 249.0/255.0, green: 249.0/255.0, blue: 249.0/255.0, alpha: 1.0)
    }
    static func mainColorScheme1() -> UIColor {
        return UIColor(red: 29.0/255.0, green: 53.0/255.0, blue: 87.0/255.0, alpha: 1.0)
    }
    static func mainColorScheme2() -> UIColor {
        return UIColor(red: 29.0/255.0, green: 53.0/255.0, blue: 87.0/255.0, alpha: 1.0)
    }
    static func mainColorScheme3() -> UIColor {
        return UIColor(red: 29.0/255.0, green: 53.0/255.0, blue: 87.0/255.0, alpha: 1.0)
    }
    static func complement1() -> UIColor {
        return UIColor(red: 228.0/255.0, green: 253.0/255.0, blue: 225.0/255.0, alpha: 1.0)
    }
    static func complement2() -> UIColor {
        return UIColor(red: 29.0/255.0, green: 53.0/255.0, blue: 87.0/255.0, alpha: 1.0)
    }
    static func complement3() -> UIColor {
        return UIColor(red: 29.0/255.0, green: 53.0/255.0, blue: 87.0/255.0, alpha: 1.0)
    }
    static func buttonGreen() -> UIColor {
        return UIColor(red: 33.0/255.0, green: 176.0/255.0, blue: 66.0/255.0, alpha: 1.0)
    }
    
    
    
    
    static func barGray() -> UIColor {
        return UIColor(red: 242.0/255.0, green: 242.0/255.0, blue: 242.0/255.0, alpha: 0.5)
    }
    static func matteBlack() -> UIColor {
        return UIColor(red: 20.0/255.0, green: 20.0/255.0, blue: 20.0/255.0, alpha: 1.0)
    }
    static func headerOffWhite() -> UIColor {
        return UIColor(red: 249.0/255.0, green: 249.0/255.0, blue: 249.0/255.0, alpha: 1.0)
    }
    static func mainSchemeColor3() -> UIColor {
        return UIColor(red: 18.0/255.0, green: 18.0/255.0, blue: 0.0/255.0, alpha: 1.0)
    }
    static func textFieldColor() -> UIColor {
        return UIColor.white
    }
    
    
}




extension UIView {
    func anchor(top: NSLayoutYAxisAnchor?,
                left: NSLayoutXAxisAnchor?,
                bottom: NSLayoutYAxisAnchor?,
                right: NSLayoutXAxisAnchor?,
                paddingTop: CGFloat,
                paddingLeft: CGFloat,
                paddingBottom: CGFloat,
                paddingRight: CGFloat,
                width: CGFloat,
                height: CGFloat) {
        translatesAutoresizingMaskIntoConstraints = false
        if let top = top {
            self.topAnchor.constraint(equalTo: top, constant: paddingTop).isActive = true
        }
        if let left = left {
            self.leftAnchor.constraint(equalTo: left, constant: paddingLeft).isActive = true
        }
        if let bottom = bottom {
            bottomAnchor.constraint(equalTo: bottom, constant: paddingBottom).isActive = true
        }
        if let right = right {
            rightAnchor.constraint(equalTo: right, constant: -paddingRight).isActive = true
        }
        if width != 0 {
            widthAnchor.constraint(equalToConstant: width).isActive = true
        }
        if height != 0 {
            heightAnchor.constraint(equalToConstant: height).isActive = true
        }
    }
}
