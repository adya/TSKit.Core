import Foundation

/// Represents a data size in common units without overflows.
/// When any of the unit has overflow it will be adjusted and extra value will be shifted to higher unit.
public struct DataSize<IntegerType>: Comparable where IntegerType: FixedWidthInteger {
    
    /// Bytes portion of the size.
    let bytes: IntegerType
    
    /// Kilobytes portion of the size.
    let kilobytes: IntegerType
    
    /// Megabytes portion of the size.
    let megabytes: IntegerType
    
    /// Gigabytes portion of the size.
    let gigabytes: IntegerType
    
    /// Terabytes portion of the size.
    let terabytes: IntegerType
    
    /// Initializes `DataSize` object with specified units.
    /// - Note: Any overflows will be resolved and affected units will be adjusted.
    ///         e.g. `1025 kilobytes` will be represented as `1 megabyte` and `1 kilobyte`.
    init(terabytes: IntegerType = 0,
         gigabytes: IntegerType = 0,
         megabytes: IntegerType = 0,
         kilobytes: IntegerType = 0,
         bytes: IntegerType = 0) {
        var kBytes: IntegerType = 0
        var mBytes: IntegerType = 0
        var gBytes: IntegerType = 0
        var tBytes: IntegerType = 0
        
        (self.bytes, kBytes) = DataSize.calculateOverflow(bytes)
        (self.kilobytes, mBytes) = DataSize.calculateOverflow(kilobytes + kBytes)
        (self.megabytes, gBytes) = DataSize.calculateOverflow(megabytes + mBytes)
        (self.gigabytes, tBytes) = DataSize.calculateOverflow(gigabytes + gBytes)
        self.terabytes = terabytes + tBytes
    }
}

// MARK: - Unit representations
public extension DataSize {
    
    /// Total size in bytes.
    /// - Note: Unlike `bytes` property, which returns only bytes portion of the size,
    ///         this one returns size represented in bytes. (e.g `2048 b`)
    var totalBytes: IntegerType {
        return IntegerType(representation(in: .byte))
    }
    
    /// Total size represented in kilobytes.
    /// - Note: Unlike `kilobytes` property, which returns only kilobytes portion of the size,
    ///         this one returns size represented in kilobytes. (e.g `1.25 Kb`)
    var totalKilobytes: Double {
        return representation(in: .kilobyte)
    }
    
    /// Total size represented in megabytes.
    /// - Note: Unlike `megabytes` property, which returns only megabytes portion of the size,
    ///         this one returns size represented in megabytes. (e.g `1.25 Mb`)
    var totalMegabytes: Double {
        return representation(in: .megabyte)
    }
    
    /// Total size represented in gigabytes.
    /// - Note: Unlike `gigabytes` property, which returns only gigabytes portion of the size,
    ///         this one returns size represented in gigabytes. (e.g `1.25 Gb`)
    var totalGigabytes: Double {
        return representation(in: .gigabyte)
    }
    
    /// Total size represented in terabytes.
    /// - Note: Unlike `terabytes` property, which returns only terabytes portion of the size,
    ///         this one returns size represented in terabytes. (e.g `1.25 Tb`)
    var totalTerabytes: Double {
        return representation(in: .terabyte)
    }
    
    /// Calculates representation of the size in specified `unit`.
    /// - Returns: Number of units in size.
    private func representation(in unit: Unit) -> Double {
        let conversions: [(Unit, IntegerType)] = [(.byte, bytes),
                                                  (.kilobyte, kilobytes),
                                                  (.megabyte, megabytes),
                                                  (.gigabyte, gigabytes),
                                                  (.terabyte, terabytes)]
        
        return conversions.reduce(0.0) { $0 + $1.0.convert($1.1, to: unit) }
    }
}

// MARK: - Operators.
public extension DataSize {
    
    static func -(lhs: DataSize, rhs: DataSize) -> DataSize {
        let lBytes = lhs.totalBytes
        let rBytes = rhs.totalBytes
        let result = lBytes > rBytes ? lBytes.unsafeSubtracting(rBytes) : rBytes.unsafeSubtracting(lBytes)
        return DataSize(bytes: result)
    }
    
    static func +(lhs: DataSize, rhs: DataSize) -> DataSize {
        return DataSize(bytes: lhs.totalBytes.unsafeAdding(rhs.totalBytes))
    }
    
    static func -=(lhs: inout DataSize, rhs: DataSize) {
        lhs = lhs - rhs
    }
    
    static func +=(lhs: inout DataSize, rhs: DataSize) {
        lhs = lhs + rhs
    }
    
    static func ==(lhs: DataSize, rhs: DataSize) -> Bool {
        return lhs.totalBytes == rhs.totalBytes
    }
    
    static func <(lhs: DataSize, rhs: DataSize) -> Bool {
        return lhs.totalBytes < rhs.totalBytes
    }
}

// MARK: - CustomStringConvertible
extension DataSize: CustomStringConvertible {
    
    public var description: String {
        return "\(terabytes) \(Unit.terabyte.label), " +
            "\(gigabytes) \(Unit.gigabyte.label), " +
            "\(megabytes) \(Unit.megabyte.label), " +
            "\(kilobytes) \(Unit.kilobyte.label), " +
        "\(bytes) \(Unit.byte.label)"
    }
    
    public var shortDescription: String {
        var res = ""
        if bytes > 0 {
            res = "\(bytes) \(Unit.byte.label)"
        }
        
        if kilobytes > 0 {
            res = "\(kilobytes) \(Unit.kilobyte.label)," + res
        }
        
        if megabytes > 0 {
            res = "\(megabytes) \(Unit.megabyte.label)," + res
        }
        
        if gigabytes > 0 {
            res = "\(gigabytes) \(Unit.gigabyte.label)," + res
        }
        
        if terabytes > 0 {
            res = "\(terabytes) \(Unit.terabyte.label)," + res
        }
        return res
    }
    
    /// String representation of the size with the greatest unit only.
    public var maxDescription: String {
        if terabytes > 0 {
            return "\(totalTerabytes) \(Unit.terabyte.label)"
        } else if gigabytes > 0 {
            return "\(totalGigabytes) \(Unit.gigabyte.label)"
        } else if megabytes > 0 {
            return "\(totalMegabytes) \(Unit.megabyte.label)"
        } else if kilobytes > 0 {
            return "\(totalKilobytes) \(Unit.kilobyte.label)"
        } else {
            return "\(totalBytes) \(Unit.byte.label)"
        }
    }
}

// MARK: - Calculations
private extension DataSize {
    
    /// Calculates unit overflow and reminder when increasing unit to the next order of magnitude.
    /// - Parameter unit: Units of lower order of magnitude in which overflow may occur.
    /// - Returns: Tuple with reminder units of the overflow and number of overflown units.
    static func calculateOverflow(_ unit: IntegerType) -> (reminder: IntegerType, overflow: IntegerType) {
        let overflow = Unit.overflow(in: unit)
        let reminder = unit - Unit.decrease(overflow)
        return (reminder, overflow)
    }
}

// MARK: - DataSize.Unit
private extension DataSize {
    
    /// Order of magnitude of the unit to which `1024` should be raised in order to calculate bytes.
    enum Unit: Int {
        
        case byte = 0
        
        case kilobyte = 1
        
        case megabyte = 2
        
        case gigabyte = 3
        
        case terabyte = 4
        
        var label: String {
            switch self {
                
            case .byte:
                return "b"
            case .kilobyte:
                return "Kb"
            case .megabyte:
                return "Mb"
            case .gigabyte:
                return "Gb"
            case .terabyte:
                return "Tb"
            }
        }
        
        /// Converts specified `number` of units to `targetUnit` units.
        /// - Parameter number: Number of units to be converted.
        /// - Parameter targetUnit: Unit to which number should be converted.
        /// - Note: When converting from higher units to lower resulting value will be integer.
        /// - Returns: Number of converted units.
        func convert(_ number: IntegerType, to targetUnit: Unit) -> Double {
            let conversionFactor = pow(1024.0, Double(self.rawValue - targetUnit.rawValue))
            return Double(number)! * conversionFactor
        }
        
        /// Calculates unit overflow when increasing unit to the next order of magnitude.
        static func overflow(in units: IntegerType) -> IntegerType {
            return IntegerType(Unit.increase(units))
        }
        
        static func increase(_ units: IntegerType) -> Double {
            return Unit.byte.convert(units, to: Unit.kilobyte)
        }
        
        static func decrease(_ units: IntegerType) -> IntegerType {
            return IntegerType(Unit.kilobyte.convert(units, to: Unit.byte))
        }
    }
}

// MARK: - Double + FixedWidthInteger
private extension Double {
    
    init?<T>(_ integer: T) where T: FixedWidthInteger {
        switch integer {
        case let num as UInt: self = Double(num)
        case let num as UInt8: self = Double(num)
        case let num as UInt16: self = Double(num)
        case let num as UInt32: self = Double(num)
        case let num as UInt64: self = Double(num)
        case let num as Int: self = Double(num)
        case let num as Int8: self = Double(num)
        case let num as Int16: self = Double(num)
        case let num as Int32: self = Double(num)
        case let num as Int64: self = Double(num)
        default: return nil
        }
    }
}
