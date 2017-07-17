//
//  UIImageExtension.swift
//  Clearry
//
//  Created by Dmytro Vorobiov on 20.04.16.
//  Copyright © 2016 dvor. All rights reserved.
//

import UIKit

extension UIImage {
    class func image(with color: UIColor, size: CGSize) -> UIImage {
        let rect = CGRect(origin: CGPoint.zero, size: size)

        UIGraphicsBeginImageContext(rect.size)
        let context = UIGraphicsGetCurrentContext()

        context?.setFillColor(color.cgColor)
        context?.fill(rect)

        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()

        return image!
    }
}
