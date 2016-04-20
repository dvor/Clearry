//
//  UIColorExtension.swift
//  Clearry
//
//  Created by Dmytro Vorobiov on 21.04.16.
//  Copyright © 2016 dvor. All rights reserved.
//

import UIKit

extension UIColor {
    class func mainColor() -> UIColor {
        return UIColor(red: 255.0 / 255.0, green: 193.0 / 255.0, blue: 7.0 / 255.0, alpha: 1.0)
    }

    class func secondaryColor() -> UIColor {
        return UIColor(white: 80.0 / 255.0, alpha: 1.0)
    }

    class func recycleBinColor() -> UIColor {
        return UIColor(white: 139.0 / 255.0, alpha: 0.3)
    }
}
