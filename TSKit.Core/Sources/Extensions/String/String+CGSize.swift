/// - Since: 01/20/2018
/// - Author: Arkadii Hlushchevskyi
/// - Copyright: © 2019. Arkadii Hlushchevskyi.
/// - Seealso: https://github.com/adya/TSKit.Core/blob/master/LICENSE.md

import Foundation

extension String {
    
    /// Calculates size of string's bounding rectangle using specified `font` and constrained width and height.
    /// - Parameter font: Desired `UIFont` of the string to be bounded.
    /// - Parameter maxWidth: Desired maximum width of the bounding rectangle.
    /// - Parameter maxHeight: Desired maximum height of the bounding rectangle.
    /// - Returns: Size of the bounding rectangle which fits content of the string.
    func size(with font: UIFont, constrainingWidth maxWidth: CGFloat = .greatestFiniteMagnitude, constrainingHeight maxHeight: CGFloat = .greatestFiniteMagnitude) -> CGSize {
        let maxSize = CGSize(width: maxWidth, height: maxHeight)
        let attributes: [NSAttributedStringKey : Any] = [NSAttributedStringKey.font : font]
        
        return self.boundingRect(with: maxSize,
                                 options: [.usesFontLeading, .usesLineFragmentOrigin],
                                 attributes: attributes,
                                 context: nil).size
    }
    
    /// Calculates height of string's bounding rectangle using specified `font` and constrained width.
    /// - Parameter font: Desired `UIFont` of the string to be bounded.
    /// - Parameter maxWidth: Desired maximum width of the bounding rectangle.
    /// - Returns: Height of the bounding rectangle which fits content of the string.
    func height(with font: UIFont, constrainingWidth maxWidth: CGFloat = .greatestFiniteMagnitude) -> CGFloat {
        return size(with: font, constrainingWidth: maxWidth).height
    }
    
    /// Calculates width of string's bounding rectangle using specified `font` and constrained height.
    /// - Parameter font: Desired `UIFont` of the string to be bounded.
    /// - Parameter maxHeight: Desired maximum height of the bounding rectangle.
    func width(with font: UIFont, constrainingHeight maxHeight: CGFloat = .greatestFiniteMagnitude) -> CGFloat {
        return size(with: font, constrainingHeight: maxHeight).width
    }
}

// MARK: - String size.
extension NSAttributedString {
    
    /// Calculates size of string's bounding rectangle using specified `font` and constrained width and height.ß
    /// - Parameter maxWidth: Desired maximum width of the bounding rectangle.
    /// - Parameter maxHeight: Desired maximum height of the bounding rectangle.
    /// - Returns: Size of the bounding rectangle which fits content of the string.
    func size(constrainingWidth maxWidth: CGFloat = .greatestFiniteMagnitude, constrainingHeight maxHeight: CGFloat = .greatestFiniteMagnitude) -> CGSize {
        let maxSize = CGSize(width: maxWidth, height: maxHeight)
        
        return self.boundingRect(with: maxSize,
                                 options: [.usesFontLeading, .usesLineFragmentOrigin],
                                 context: nil).size
    }
    
    /// Calculates height of string's bounding rectangle using specified `font` and constrained width.
    /// - Parameter maxWidth: Desired maximum width of the bounding rectangle.
    /// - Returns: Height of the bounding rectangle which fits content of the string.
    func height(constrainingWidth maxWidth: CGFloat = .greatestFiniteMagnitude) -> CGFloat {
        return size(constrainingWidth: maxWidth).height
    }
    
    /// Calculates width of string's bounding rectangle using specified `font` and constrained height.
    /// - Parameter maxHeight: Desired maximum height of the bounding rectangle.
    /// - Returns: Width of the bounding rectangle which fits content of the string.
    func width(constrainingHeight maxHeight: CGFloat = .greatestFiniteMagnitude) -> CGFloat {
        return size(constrainingHeight: maxHeight).width
    }
}
