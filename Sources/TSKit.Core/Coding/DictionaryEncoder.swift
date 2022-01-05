// - Since: 10/02/2019
// - Author: Arkadii Hlushchevskyi
// - Copyright: © 2022. Arkadii Hlushchevskyi.
// - Seealso: https://github.com/adya/TSKit.Core/blob/master/LICENSE.md

import Foundation

public class DictionaryEncoder {

    private let encoder = JSONEncoder()

    public var dateEncodingStrategy: JSONEncoder.DateEncodingStrategy {
        set { encoder.dateEncodingStrategy = newValue }
        get { return encoder.dateEncodingStrategy }
    }

    public var dataEncodingStrategy: JSONEncoder.DataEncodingStrategy {
        set { encoder.dataEncodingStrategy = newValue }
        get { return encoder.dataEncodingStrategy }
    }

    public var nonConformingFloatEncodingStrategy: JSONEncoder.NonConformingFloatEncodingStrategy {
        set { encoder.nonConformingFloatEncodingStrategy = newValue }
        get { return encoder.nonConformingFloatEncodingStrategy }
    }

    public var keyEncodingStrategy: JSONEncoder.KeyEncodingStrategy {
        set { encoder.keyEncodingStrategy = newValue }
        get { return encoder.keyEncodingStrategy }
    }

    public init() {}
    
    private func encodeJson<T>(_ value: T) throws -> Any where T: Encodable {
        try encoder.encode(value) ==> { try JSONSerialization.jsonObject(with: $0) }
    }
    
    public func encode<T>(_ value: T) throws -> [String: Any] where T: Encodable {
        let object = try encodeJson(value)
        guard let dictionary = object as? [String: Any] else {
            throw EncodingError.invalidValue(object, EncodingError.Context(codingPath: [], debugDescription: "Underlying object could not be represented as Dictionary"))
        }
        
        return dictionary
    }
    
    public func encode<T>(_ value: T) throws -> [[String: Any]] where T: Encodable {
        let object = try encodeJson(value)
        guard let array = object as? [[String: Any]] else {
            throw EncodingError.invalidValue(object, EncodingError.Context(codingPath: [], debugDescription: "Underlying object could not be represented as Array"))
        }
        
        return array
    }
}
