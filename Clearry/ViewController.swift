//
//  ViewController.swift
//  Clearry
//
//  Created by Dmytro Vorobiov on 20.04.16.
//  Copyright © 2016 dvor. All rights reserved.
//

import UIKit

private struct Constants {

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
        clearIfNeededAndUpdateUI()
    }

    override func prefersStatusBarHidden() -> Bool {
        return true
    }

    @IBAction func clearClipboardButtonPressed(sender: AnyObject) {
        clearPasteboardAnimated(true)
    }

    func willEnterForegroundNotification() {
        clearIfNeededAndUpdateUI()
    }
}

private extension ViewController {
    func setupViews() {
        let settingsImage = settingsButton.imageForState(.Normal)!.imageWithRenderingMode(.AlwaysTemplate)
        settingsButton.setImage(settingsImage, forState: .Normal)
        settingsButton.tintColor = UIColor.mainColor()

        imageView.image = UIImage(named: "bin-full")!.imageWithRenderingMode(.AlwaysTemplate)
        imageView.tintColor = UIColor.recycleBinColor()

        let image = UIImage.imageWithColor(UIColor.mainColor(), size: CGSize(width: 1, height: 1))

        clearClipboardButton.setBackgroundImage(image, forState: .Normal)
        clearClipboardButton.setTitleColor(.whiteColor(), forState: .Normal)
        clearClipboardButton.layer.cornerRadius = 8.0
        clearClipboardButton.layer.masksToBounds = true

        clearedLabel.alpha = 0.0
        clearedLabel.textColor = UIColor.secondaryColor()
    }

    func clearIfNeededAndUpdateUI() {
        let items = UIPasteboard.generalPasteboard().items.count
        let autoClean = UserDefaults().automaticallyClean

        switch (items, autoClean) {
            case (let items, _) where items == 0:
                switchToState(.Empty, animated: false)
            case (_, true):
                clearPasteboardAnimated(false)
            case (_, false):
                switchToState(.Full, animated: false)
        }
    }

    func clearPasteboardAnimated(animated: Bool) {
        UIPasteboard.generalPasteboard().items = [AnyObject]()
        switchToState(.Cleared, animated: animated)
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
