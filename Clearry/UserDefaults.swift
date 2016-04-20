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
            return boolForKey(Keys.AutomaticallyClean.rawValue, defaultValue: false)
        }
        set {
            setBool(newValue, forKey: Keys.AutomaticallyClean.rawValue)
        }
    }
}

private extension UserDefaults {
    enum Keys: String {
        case AutomaticallyClean
    }

    func setBool(value: Bool, forKey key: String) {
        let defaults = NSUserDefaults.standardUserDefaults()
        defaults.setBool(value, forKey: key)
        defaults.synchronize()
    }

    func boolForKey(key: String, defaultValue: Bool) -> Bool {
        let defaults = NSUserDefaults.standardUserDefaults()

        if let result = defaults.objectForKey(key) {
            return result.boolValue
        }
        else {
            return defaultValue
        }
    }
}
