import UIKit
import ImageIO


public extension UIImage {
	
    /// Creates an animated `UIImage` object representing `gif` image in specified `data`.
    /// - Parameter data: Data of the `gif` image.
    /// - Returns: `UIImage` object representing `gif` image or `nil` if `data` could not be read as `gif` image.
    static func animatedImage(withGifData data: Data) -> UIImage? {
        guard let source = CGImageSourceCreateWithData(data as CFData, nil) else { return nil }
        
        return UIImage.animatedImage(from: source)
    }
    
    /// Creates an animated `UIImage` object representing `gif` image from file located at given `url`.
    /// - Parameter url: `URL` of the `gif` image file.
    /// - Returns: `UIImage` object representing `gif` image or `nil` if file was not found or could not be read as `gif` image.
    static func animatedImage(withGifUrl url: URL) -> UIImage? {
        guard let imageData = try? Data(contentsOf: url) else { return nil }
        
        return animatedImage(withGifData: imageData)
    }
	
    /// Creates an animated `UIImage` object representing `gif` image from bundle resource.
    /// - Parameter name: Name of the resource representing `gif` file.
    /// - Returns: `UIImage` object representing `gif` image or `nil` if resource could not be read as `gif` image.
    static func animatedImage(withGifNamed name: String) -> UIImage? {
        guard let bundleUrl = Bundle.main.url(forResource: name, withExtension: "gif") else { return nil }
        
        return animatedImage(withGifUrl: bundleUrl)
    }
}

// MARK: - Private
private extension CGImageSource {
    
    /// Reads delay for a single image of `gif` at given `index`.
    /// - Returns: Delay of the image in seconds.
    func delayForImage(atIndex index: Int) -> Float {
        let minValue: Float = 0.1
        guard let gifProperties = CGImageSourceCopyPropertiesAtIndex(self, index, nil) as? [String : Any] ,
            let delay = (gifProperties[kCGImagePropertyGIFDelayTime as String] as? NSNumber)?.floatValue,
            delay > minValue else {
                return minValue
        }
        return delay
    }
}

// MARK: - Private factory
private extension UIImage {
    
    static func animatedImage(from source: CGImageSource) -> UIImage? {
        let frames: [(image: CGImage, delay: Int)]
        frames = (0..<CGImageSourceGetCount(source)).flatMap {
            guard let image = CGImageSourceCreateImageAtIndex(source, $0, nil) else { return nil }
            
            let delaySeconds = source.delayForImage(atIndex: $0)
            return (image, Int(delaySeconds * 1000.0))
        }
        
        let duration = frames.reduce(0) { $0 + $1.delay }
        let divisor = gcd(for: frames.map { $0.delay })
        let imageFrames = frames.flatMap { Array(repeating: UIImage(cgImage: $0.image), count: $0.delay / divisor) }
        
        return UIImage.animatedImage(with: imageFrames, duration: TimeInterval(duration) / 1000.0)
    }
}

// MARK: - Algorythm

private func gcd(for pair: (Int, Int)) -> Int {
    let a = max(pair.0, pair.1)
    let b = min(pair.0, pair.1)
    let reminder = a % b
    
    if reminder == 0 {
        return b
    } else {
        return gcd(for: (b, reminder))
    }
}

private func gcd(for array: [Int]) -> Int {
    guard let first = array.first else { return 1 }
    return array.reduce(first) { gcd(for: ($1, $0))}
}
