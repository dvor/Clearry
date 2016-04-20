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

private enum State {
    case Full
    case Empty
    case Cleared
}

class ViewController: UIViewController {
    @IBOutlet weak var settingsButton: UIButton!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var clearClipboardButton: UIButton!
    @IBOutlet weak var clearedLabel: UILabel!

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)

        NSNotificationCenter.defaultCenter().addObserver(
                self,
                selector: #selector(ViewController.willEnterForegroundNotification),
                name: UIApplicationWillEnterForegroundNotification,
                object: nil)
    }

    deinit {
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        setupViews()
        switchToActualState()
    }

    override func prefersStatusBarHidden() -> Bool {
        return true
    }

    @IBAction func settingsButtonPressed(sender: AnyObject) {
    }

    @IBAction func clearClipboardButtonPressed(sender: AnyObject) {
        UIPasteboard.generalPasteboard().items = [AnyObject]()
        switchToState(.Cleared, animated: true)
    }

    func willEnterForegroundNotification() {
        switchToActualState()
    }
}

private extension ViewController {
    func setupViews() {
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

    func switchToActualState() {
        if UIPasteboard.generalPasteboard().items.count > 0 {
            switchToState(.Full, animated: false)
        }
        else {
            switchToState(.Empty, animated: false)
        }
    }

    func switchToState(state: State, animated: Bool) {
        let buttonAlpha: CGFloat
        let labelAlpha: CGFloat

        switch state {
            case .Full:
                buttonAlpha = 1.0
                labelAlpha = 0.0
                imageView.image = UIImage(named: "bin-full")!.imageWithRenderingMode(.AlwaysTemplate)
            case .Empty:
                buttonAlpha = 0.0
                labelAlpha = 1.0
                imageView.image = UIImage(named: "bin-empty")!.imageWithRenderingMode(.AlwaysTemplate)
                clearedLabel.text = "Clipboard is empty"
            case .Cleared:
                buttonAlpha = 0.0
                labelAlpha = 1.0
                imageView.image = UIImage(named: "bin-empty")!.imageWithRenderingMode(.AlwaysTemplate)
                clearedLabel.text = "Cleared!"
        }

        func closure() {
            clearClipboardButton.alpha = buttonAlpha
            clearedLabel.alpha = labelAlpha
        }

        if animated {
            UIView.animateWithDuration(Constants.AnimationDuration, animations: closure)

            let transition = CATransition()
            transition.duration = Constants.AnimationDuration
            transition.type = kCATransitionFade
            imageView.layer.addAnimation(transition, forKey: nil)
        }
        else {
            closure()
        }
    }
}
