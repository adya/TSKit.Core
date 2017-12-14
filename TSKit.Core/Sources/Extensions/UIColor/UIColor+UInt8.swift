import UIKit

// MARK: - UIColor Convenience initializers
public extension UIColor {
    
    public convenience init(alpha a: UInt8, red r: UInt8, green g: UInt8, blue b: UInt8) {
        self.init(red: CGFloat(r)/255.0,
                  green: CGFloat(g)/255.0,
                  blue: CGFloat(b)/255.0,
                  alpha: CGFloat(a)/255.0)
    }
    
    public convenience init(red r: UInt8, green g: UInt8, blue b: UInt8) {
        self.init(alpha: 255, red: r, green: g, blue: b)
    }
    
    public convenience init(alpha: UInt8, white: UInt8) {
        self.init(white: CGFloat(white)/255.0, alpha : CGFloat(alpha)/255.0)
    }
    
    public convenience init(white: UInt8) {
        self.init(alpha: 255, white: white)
    }
    
    /// Creates `UIColor` using a single `UInt` value representing color.
    /// (Example: 0xFFFFFFFF).
    public convenience init(value : UInt) {
        self.init(alpha: UInt8((value & 0xFF000000) >> 24),
                  red: UInt8((value & 0x00FF0000) >> 16),
                  green: UInt8((value & 0x0000FF00) >> 8),
                  blue: UInt8((value & 0x000000FF) >> 0))
    }
    
    /// Creates `UIColor` using string representing color.
    /// (Example: "#FFFFFFFF" or "FFFFFFFF").
    public convenience init?(hex : String) {
        var hex = hex
        if hex.hasPrefix("#") {
            hex = String(hex[hex.index(hex.startIndex, offsetBy: 1)...])
        }
        
        if hex.count == 6 {
            hex = "FF" + hex
        }
        if let value = UInt(hex, radix: 16) {
            self.init(value: value)
        }
        return nil
    }
}
