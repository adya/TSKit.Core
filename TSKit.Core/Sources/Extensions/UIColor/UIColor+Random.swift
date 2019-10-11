// - Since: 10/04/2019
// - Author: Arkadii Hlushchevskyi
// - Copyright: © 2019. Arkadii Hlushchevskyi.
// - Seealso: https://github.com/adya/TSKit.Core/blob/master/LICENSE.md

import UIKit

public extension UIColor {

    /// Generates random color from pastel pallete and mixes it with given `color` if provided.
    /// Mixing another color adjusts available color range.
    /// - Parameter mixColor: A color to be mixed with generated pastel color.
    /// - Returns: Created color.
    static func randomPastel(mixedWith mixColor: UIColor? = nil) -> UIColor {

        let randomColorGenerator = { () -> CGFloat in
            CGFloat(arc4random() % 256) / 256
        }

        var red = randomColorGenerator()
        var green = randomColorGenerator()
        var blue = randomColorGenerator()

        // Mix the color
        if let mixColor = mixColor {
            var mixRed: CGFloat = 0, mixGreen: CGFloat = 0, mixBlue: CGFloat = 0
            mixColor.getRed(&mixRed, green: &mixGreen, blue: &mixBlue, alpha: nil)

            red = (red + mixRed) / 2
            green = (green + mixGreen) / 2
            blue = (blue + mixBlue) / 2
        }

        return UIColor(red: red, green: green, blue: blue, alpha: 1)
    }
}
