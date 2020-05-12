import Foundation

public protocol UDefaults {
    var userDefaults: UserDefaults { get }
}

public class UMapKey<T: Codable> {
    private unowned let userDefaults: UserDefaults
    private let key: String
    private let defaultValue: T
    private let decoder: JSONDecoder
    private let encoder: JSONEncoder
    
    init(_ uDefaults: UDefaults, _ key: String, defValue: T) {
        self.userDefaults = uDefaults.userDefaults
        self.key = key
        self.decoder = .init()
        self.encoder = .init()
        self.defaultValue = defValue
    }
    
    private func doesUserDefaultSupport() -> Bool {
        return T.self is NSNumber.Type ||
            T.self is NSString.Type ||
            T.self is NSDate.Type ||
            T.self is String.Type ||
            T.self is Int.Type ||
            T.self is Int8.Type ||
            T.self is Int16.Type ||
            T.self is Int32.Type ||
            T.self is Int64.Type ||
            T.self is UInt8.Type ||
            T.self is UInt16.Type ||
            T.self is UInt32.Type ||
            T.self is UInt64.Type ||
            T.self is Float.Type ||
            T.self is Double.Type ||
            T.self is Date.Type ||
            T.self is Data.Type
    }
    
    
    subscript(indexKey: String) -> T {
        get{
            let currentKey = "\(key)[\(indexKey)]"
            if (doesUserDefaultSupport()) {
                return (userDefaults.value(forKey: currentKey) as? T) ?? defaultValue
            }
            
            if let data = userDefaults.value(forKey: currentKey) as? Data {
                return try! decoder.decode(T.self, from: data)
            }
            return defaultValue
        }
        
        set(newValue) {
            let currentKey = "\(key)[\(indexKey)]"
            if (doesUserDefaultSupport()) {
                userDefaults.setValue(newValue, forKey: currentKey)
            } else {
                userDefaults.setValue(try! encoder.encode(newValue), forKey: currentKey)
            }
        }
    }
}

public class UKey<T:Codable> {
    
    private unowned let userDefaults: UserDefaults
    private let key: String
    private let defaultValue: T
    private let decoder: JSONDecoder
    private let encoder: JSONEncoder
    
    init(_ uDefaults: UDefaults, _ key: String, defValue: T) {
        self.userDefaults = uDefaults.userDefaults
        self.key = key
        self.decoder = .init()
        self.encoder = .init()
        self.defaultValue = defValue
    }
    
    private func doesUserDefaultSupport() -> Bool {
        return T.self is NSNumber.Type ||
            T.self is NSString.Type ||
            T.self is NSDate.Type ||
            T.self is String.Type ||
            T.self is Int.Type ||
            T.self is Int8.Type ||
            T.self is Int16.Type ||
            T.self is Int32.Type ||
            T.self is Int64.Type ||
            T.self is UInt8.Type ||
            T.self is UInt16.Type ||
            T.self is UInt32.Type ||
            T.self is UInt64.Type ||
            T.self is Float.Type ||
            T.self is Double.Type ||
            T.self is Date.Type ||
            T.self is Data.Type
    }
    
    var value: T {
        get{
            if (doesUserDefaultSupport()) {
                return (userDefaults.value(forKey: key) as? T) ?? defaultValue
            }
            
            if let data = userDefaults.value(forKey: key) as? Data {
                return try! decoder.decode(T.self, from: data)
            }
            return defaultValue
        }
        
        set(newValue) {
            if (doesUserDefaultSupport()) {
                userDefaults.setValue(newValue, forKey: key)
            } else {
                userDefaults.setValue(try! encoder.encode(newValue), forKey: key)
            }
        }
    }
}
