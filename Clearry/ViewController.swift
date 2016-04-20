//
//  ViewController.swift
//  Clearry
//
//  Created by Dmytro Vorobiov on 20.04.16.
//  Copyright © 2016 dvor. All rights reserved.
//

import UIKit

private struct Constants {
    static let MainColor = UIColor(red: 255.0 / 255.0, green: 193.0 / 255.0, blue: 7.0 / 255.0, alpha: 1.0)
    static let BinColor = UIColor(white: 139.0 / 255.0, alpha: 0.3)
    static let LabelColor = UIColor(white: 80.0 / 255.0, alpha: 1.0)

    static let AnimationDuration = 0.15
}

class ViewController: UIViewController {
    @IBOutlet weak var settingsButton: UIButton!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var clearClipboardButton: UIButton!
    @IBOutlet weak var clearedLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()

        let settingsImage = settingsButton.imageForState(.Normal)!.imageWithRenderingMode(.AlwaysTemplate)
        settingsButton.setImage(settingsImage, forState: .Normal)
        settingsButton.tintColor = Constants.MainColor

        imageView.image = UIImage(named: "bin-full")!.imageWithRenderingMode(.AlwaysTemplate)
        imageView.tintColor = Constants.BinColor

        let image = UIImage.imageWithColor(Constants.MainColor, size: CGSize(width: 1, height: 1))

        clearClipboardButton.setBackgroundImage(image, forState: .Normal)
        clearClipboardButton.setTitleColor(.whiteColor(), forState: .Normal)
        clearClipboardButton.layer.cornerRadius = 8.0
        clearClipboardButton.layer.masksToBounds = true

        clearedLabel.alpha = 0.0
        clearedLabel.textColor = Constants.LabelColor
    }

    @IBAction func settingsButtonPressed(sender: AnyObject) {
    }

    @IBAction func clearClipboardButtonPressed(sender: AnyObject) {
        UIView.animateWithDuration(Constants.AnimationDuration) { [unowned self] in
            self.clearClipboardButton.alpha = 0.0
            self.clearedLabel.alpha = 1.0
        }

        self.imageView.image = UIImage(named: "bin-empty")!.imageWithRenderingMode(.AlwaysTemplate)

        let transition = CATransition()
        transition.duration = Constants.AnimationDuration
        transition.type = kCATransitionFade
        imageView.layer.addAnimation(transition, forKey: nil)
    }
}
