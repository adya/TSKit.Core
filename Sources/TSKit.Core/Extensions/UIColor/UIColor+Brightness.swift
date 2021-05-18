// - Since: 01/20/2018
// - Author: Arkadii Hlushchevskyi
// - Copyright: © 2020. Arkadii Hlushchevskyi.
// - Seealso: https://github.com/adya/TSKit.Core/blob/master/LICENSE.md
#if os(iOS)
import UIKit

// MARK: - UIColor brightness adjustments
public extension UIColor {
    
    /// Creates `UIColor` by brightening existing one.
    /// - Parameter correctionFactor: Brightning factor defining how much each color component should be brightened.
    ///                               Should be in `(0...1)` range.
    /// - Parameter preserveAlpha: Flag indicating whether or not created `UIColor` should inherit alpha component.
    /// - Returns: Brighten `UIColor` or `nil` if `correctionFactor` was invalid.
    func brighten(by correctionFactor : Float, preserveAlpha : Bool = true) -> UIColor? {
        guard (0.0...1.0).contains(correctionFactor) else {
            print("Color '\(self)' can be lightened only with values in range (0; 1]")
            return nil
        }
        return changeBrightness(by: correctionFactor, preserveAlpha: preserveAlpha)
    }
    
    /// Creates `UIColor` by darkening existing one.
    /// - Parameter correctionFactor: Darkening factor defining how much each color component should be darkened.
    ///                               Should be in `(0...1)` range.
    /// - Parameter preserveAlpha: Flag indicating whether or not created `UIColor` should inherit alpha component.
    /// - Returns: Darken `UIColor` or `nil` if `correctionFactor` was invalid.
    func darken(by correctionFactor : Float, preserveAlpha : Bool = true) -> UIColor? {
        return changeBrightness(by: -correctionFactor, preserveAlpha: preserveAlpha)
    }
    
    
    /// Creates new `UIColor` by multiplying each color component by specified `correctionFactor`.
    private func changeBrightness(by correctionFactor : Float, preserveAlpha : Bool = true) -> UIColor? {
        guard let argb = self.getARGB() else {
            return nil
        }
        
        var red = Float(argb.red)
        var green = Float(argb.green)
        var blue = Float(argb.blue)
        let alpha = (argb.alpha)
        
        red += (255 - red) * correctionFactor;
        green += (255 - green) * correctionFactor;
        blue += (255 - blue) * correctionFactor;
        
        func clamp(_ value : Float) -> UInt8 {
            return UInt8(0 > value ? 0 : (value > 255 ? 255 : value))
        }
        
        return UIColor(alpha: (preserveAlpha ? UInt8(alpha) : 255),
                       red: clamp(red),
                       green: clamp(green),
                       blue: clamp(blue))
    }
    
    /// Extracts color components from `UIColor`.
    /// - Attention: Method may fail on specific `UIColor` internal subclasses thus returning `nil`.
    /// - Returns: Tuple with color components.
    func getARGB() -> (red: UInt8, green: UInt8, blue: UInt8, alpha: UInt8)? {
        var fRed : CGFloat = 0
        var fGreen : CGFloat = 0
        var fBlue : CGFloat = 0
        var fAlpha: CGFloat = 0
        if self.getRed(&fRed, green: &fGreen, blue: &fBlue, alpha: &fAlpha) {
            let iRed = UInt8(fRed * 255.0)
            let iGreen = UInt8(fGreen * 255.0)
            let iBlue = UInt8(fBlue * 255.0)
            let iAlpha = UInt8(fAlpha * 255.0)
            return (red:iRed, green:iGreen, blue:iBlue, alpha:iAlpha)
        } else {
            print("Could not extract ARGB components from color '\(self)'")
            return nil
        }
    }
}

public extension UIColor {
    
    /// A value between `0.0` and `1.0` representing luminosity of the color.
    var luminosity: CGFloat {
        var r, g, b, a: CGFloat
        (r, g, b, a) = (0, 0, 0, 0)
        self.getRed(&r, green: &g, blue: &b, alpha: &a)
        return 0.2126 * r + 0.7152 * g + 0.0722 * b
    }
    
    /// Checks whether the color should be treated as dark.
    /// - Parameter threshold: A maximum value of luminosity when color is determined as dark.
    /// - Note: This method evaluates `luminosity` of the color and compares it to a certain threshold.
    func isDark(threshold: CGFloat = 0.82) -> Bool {
        return luminosity < threshold
    }
    
}
#endif
