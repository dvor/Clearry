//
//  UserDefaults.swift
//  Clearry
//
//  Created by Dmytro Vorobiov on 21.04.16.
//  Copyright © 2016 dvor. All rights reserved.
//

import Foundation

class UserDefaults {
    var automaticallyClean: Bool {
        get {
            return bool(for: Keys.AutomaticallyClean.rawValue, defaultValue: false)
        }
        set {
            set(bool: newValue, for: Keys.AutomaticallyClean.rawValue)
        }
    }
}

private extension UserDefaults {
    enum Keys: String {
        case AutomaticallyClean
    }

    func set(bool value: Bool, for key: String) {
        let defaults = Foundation.UserDefaults.standard
        defaults.set(value, forKey: key)
        defaults.synchronize()
    }

    func bool(for key: String, defaultValue: Bool) -> Bool {
        let defaults = Foundation.UserDefaults.standard

        if let result = defaults.object(forKey: key) {
            return (result as AnyObject).boolValue
        }
        else {
            return defaultValue
        }
    }
}
