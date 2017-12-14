import Foundation

/// Represents a data size in common units without overflows.
/// When any of the unit has overflow it will be adjusted and extra value will be shifted to higher unit.
public struct DataSize: Comparable {

    /// Bytes portion of the size.
    public let bytes: Int

    /// Kilobytes portion of the size.
    public let kilobytes: Int

    /// Megabytes portion of the size.
    public let megabytes: Int

    /// Gigabytes portion of the size.
    public let gigabytes: Int

    /// Terabytes portion of the size.
    public let terabytes: Int


    /// Initializes `DataSize` object with specified units.
    /// - Note: Any overflows will be resolved and affected units will be adjusted.
    public init(terabytes: Int = 0, gigabytes: Int = 0, megabytes: Int = 0, kilobytes: Int = 0, bytes: Int = 0) {
        var kBytes = kilobytes
        var mBytes = megabytes
        var gBytes = gigabytes
        var tBytes = terabytes

        self.bytes = DataSize.adjustUnits(bytes, higherOrderUnit: &kBytes)
        self.kilobytes = DataSize.adjustUnits(kBytes, higherOrderUnit: &mBytes)
        self.megabytes = DataSize.adjustUnits(mBytes, higherOrderUnit: &gBytes)
        self.gigabytes = DataSize.adjustUnits(gBytes, higherOrderUnit: &tBytes)
        self.terabytes = tBytes
    }

    /// Calculates extra units of higher order of magnitude contained in units of lower order of magnitude.
    /// and adjusts those to values to remove possible overflow.
    /// - Parameter lUnit: Units of lower order of magnitude in which overflow may occur.
    /// - Parameter hUnit: Inout parameter. Units of higher order of magnitude which should be adjusted in cases when overflow occurred.
    /// - Returns: Remaining units of lower order of magnitude after adjusting overflow or original value if no overflow occurred.
    fileprivate static func adjustUnits(_ lUnit: Int, higherOrderUnit hUnit: inout Int) -> Int {

        let extraHUnit = DataSize.increaseUnits(lUnit)
        let totalHUnit = hUnit + extraHUnit
        let reminderLUnit = lUnit - DataSize.decreaseUnits(extraHUnit)

        hUnit = Int(totalHUnit)
        return Int(reminderLUnit)
        // let (extraHUnit, fractionLUnit) = modf(DataSize.increaseUnits(Float(lUnit)))
        //  hUnit += Int(extraHUnit)

        //  return Int(ceil(DataSize.decreaseUnits(fractionLUnit)))
    }

    fileprivate static func decreaseUnits(_ hUnit: Float) -> Float {
        return hUnit * 1024.0
    }

    fileprivate static func decreaseUnits(_ hUnit: Int) -> Int {
        return hUnit * 1024
    }

    fileprivate static func increaseUnits(_ lUnit: Float) -> Float {
        return lUnit / 1024.0
    }

    fileprivate static func increaseUnits(_ lUnit: Int) -> Int {
        return lUnit / 1024
    }

}

// MARK: - Unit representations.
public extension DataSize {

    /// Total size in bytes.
    /// - Note: Unlike `bytes` property, which will avoid overflow, this one returns total number of bytes calculated by downgrading all higher units.
    public var totalBytes: Int {
        return bytes + DataSize.decreaseUnits(totalKilobytes)
    }

    /// Total size in kilobytes.
    /// - Note: Unlike `kilobytes` property, which will avoid overflow, this one returns total number of kilobytes calculated by downgrading all higher units.
    public var totalKilobytes: Int {
        return kilobytes + DataSize.decreaseUnits(totalMegabytes)
    }

    /// Total size in megabytes.
    /// - Note: Unlike `megabytes` property, which will avoid overflow, this one returns total number of megabytes calculated by downgrading all higher units.
    public var totalMegabytes: Int {
        return megabytes + DataSize.decreaseUnits(totalGigabytes)
    }

    /// Total size in gigabytes.
    /// - Note: Unlike `gigabytes` property, which will avoid overflow, this one returns total number of gigabytes calculated by downgrading all higher units.
    public var totalGigabytes: Int {
        return gigabytes + DataSize.decreaseUnits(terabytes)
    }

}

// MARK: - Operators.

public func - (lhs: DataSize, rhs: DataSize) -> DataSize {
    return DataSize(bytes: abs(lhs.totalBytes - rhs.totalBytes))
}

public func + (lhs: DataSize, rhs: DataSize) -> DataSize {
    return DataSize(bytes: lhs.totalBytes + rhs.totalBytes)
}

public func -= (lhs: inout DataSize, rhs: DataSize) {
    lhs = DataSize(bytes: abs(lhs.totalBytes - rhs.totalBytes))
}

public func += (lhs: inout DataSize, rhs: DataSize) {
    lhs = DataSize(bytes: lhs.totalBytes + rhs.totalBytes)
}

public func == (lhs: DataSize, rhs: DataSize) -> Bool {
    return lhs.totalBytes == rhs.totalBytes
}

public func < (lhs: DataSize, rhs: DataSize) -> Bool {
    return lhs.totalBytes < rhs.totalBytes
}

// MARK: - CustomStringConvertible
extension DataSize : CustomStringConvertible {

    public var description: String {
        return "\(terabytes) TB, \(gigabytes) GB, \(megabytes) MB, \(kilobytes) KB, \(bytes) B"
    }

    public var shortDescription: String {
        var res = ""
        if bytes > 0 {
            res = "\(bytes) B"
        }

        if kilobytes > 0 {
            res = "\(kilobytes) KB," + res
        }

        if megabytes > 0 {
            res = "\(megabytes) MB," + res
        }

        if gigabytes > 0 {
            res = "\(gigabytes) GB," + res
        }

        if terabytes > 0 {
            res = "\(terabytes) TB," + res
        }
        return res
    }


    /// String representation of the size with the greatest unit only.
    public var maxDescription: String {
        if terabytes > 0 {
            return "\(terabytes) TB"
        } else if gigabytes > 0 {
            return "\(gigabytes) GB"
        } else if megabytes > 0 {
            return "\(megabytes) MB"
        } else if kilobytes > 0 {
            return "\(kilobytes) KB"
        } else {
            return "\(bytes) B"
        }
    }
}

// MARK: - Access to `DataSize` from `Data`.
public extension Data {

    /// Size of `Data` represented by `DataSize` struct.
    public var dataSize : DataSize {
        return DataSize(bytes: count)
    }
}
