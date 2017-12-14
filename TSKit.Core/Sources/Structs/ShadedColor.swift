import UIKit
/// TSTOOLS: Description.. date 8/19/16

/// `ShadedColor` represents a color which has
public protocol ShadedColor {
    
    /// Base color.
    var regular : UIColor {get}
    
    /// Lighter version of `regular` color.
    var lighter : UIColor {get}
    
    /// Darker version of `regular` color.
    var darker : UIColor {get}
}

/// Provides `ShadedColor`s objects.
public final class ShadedColorFactory {
    
    /// Creates a `ShadedColor` shading given `color` by specified factor.
    /// - Parameter color: Source `UIColor` to be shaded.
    /// - Parameter factor: Value in range (0.0; 1.0] by which each color component will be shaded.
    /// - Returns: Shaded color.
    public class func shades(of color: UIColor, withFactor factor: Float) -> ShadedColor? {
        return shades(of: color, withDarkenFactor: factor, withLightenFactor: factor)
    }
    
    /// Creates a `ShadedColor` using specified triple of colors.
    /// - Parameter regular: Base `UIColor`.
    /// - Parameter darker: `UIColor` representing "darker" shade of `regular` color.
    /// - Parameter lighter: `UIColor` representing "lighter" shade of `regular` color.
    /// - Returns: Shaded color.
    public class func shades(of regular : UIColor, withDarker darker: UIColor, andLighter lighter: UIColor) -> ShadedColor {
        return ManualShadeColor(darker: darker, regular: regular, lighter: lighter)
    }
    
    /// Creates a `ShadedColor` shading given `color` by specified factors.
    /// - Parameter color: Source `UIColor` to be shaded.
    /// - Parameter dFactor: Value in range (0.0; 1.0] by which each color component will be darken.
    /// - Parameter lFactor: Value in range (0.0; 1.0] by which each color component will be lighten.
    /// - Returns: Shaded color.
    public class func shades(of color : UIColor, withDarkenFactor dFactor: Float, withLightenFactor lFactor: Float) -> ShadedColor? {
        return AutoShadeColor(base: color, darkShadingFactor: dFactor, lightShadingFactor: lFactor)
    }
    
}

private struct AutoShadeColor : ShadedColor {
    
    var darker : UIColor {
        return regular.darken(by: darkShadingFactor)!
    }

    var lighter : UIColor {
        return regular.brighten(by: lightShadingFactor)!
    }

    let regular : UIColor
    
    private let lightShadingFactor : Float
    private let darkShadingFactor : Float
    
    init?(base : UIColor, darkShadingFactor: Float, lightShadingFactor : Float) {
        guard base.getARGB() != nil else {
            return nil
        }
        self.regular = base
        self.lightShadingFactor = lightShadingFactor
        self.darkShadingFactor = darkShadingFactor
    }
}

private struct ManualShadeColor : ShadedColor {
    
    let darker : UIColor
    
    let regular : UIColor
   
    let lighter : UIColor
}
