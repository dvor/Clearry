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
    case full
    case empty
    case cleared
}

class ViewController: UIViewController {
    @IBOutlet weak var settingsButton: UIButton!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var clearClipboardButton: UIButton!
    @IBOutlet weak var clearedLabel: UILabel!

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)

        NotificationCenter.default.addObserver(
                self,
                selector: #selector(ViewController.willEnterForegroundNotification),
                name: UIApplication.willEnterForegroundNotification,
                object: nil)
    }

    deinit {
        NotificationCenter.default.removeObserver(self)
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        setupViews()
        clearIfNeededAndUpdateUI()
    }

    @IBAction func clearClipboardButtonPressed(_ sender: AnyObject) {
        clearPasteboardAnimated(true)
    }

    @objc func willEnterForegroundNotification() {
        clearIfNeededAndUpdateUI()
    }
}

private extension ViewController {
    func setupViews() {
        let settingsImage = settingsButton.image(for: UIControl.State())!.withRenderingMode(.alwaysTemplate)
        settingsButton.setImage(settingsImage, for: UIControl.State())
        settingsButton.tintColor = UIColor.mainColor()

        imageView.image = UIImage(named: "bin-full")!.withRenderingMode(.alwaysTemplate)
        imageView.tintColor = UIColor.recycleBinColor()

        let image = UIImage.image(with: UIColor.mainColor(), size: CGSize(width: 1, height: 1))

        clearClipboardButton.setBackgroundImage(image, for: UIControl.State())
        clearClipboardButton.setTitleColor(.white, for: UIControl.State())
        clearClipboardButton.layer.cornerRadius = 8.0
        clearClipboardButton.layer.masksToBounds = true

        clearedLabel.alpha = 0.0
        clearedLabel.textColor = UIColor.secondaryColor()
    }

    func clearIfNeededAndUpdateUI() {
        let items = UIPasteboard.general.items.count
        let autoClean = UserDefaults().automaticallyClean

        switch (items, autoClean) {
            case (let items, _) where items == 0:
                switchToState(.empty, animated: false)
            case (_, true):
                clearPasteboardAnimated(false)
            case (_, false):
                switchToState(.full, animated: false)
        }
    }

    func clearPasteboardAnimated(_ animated: Bool) {
        UIPasteboard.general.items = [AnyObject]() as! [[String : Any]]
        switchToState(.cleared, animated: animated)
    }

    func switchToState(_ state: State, animated: Bool) {
        let buttonAlpha: CGFloat
        let labelAlpha: CGFloat

        switch state {
            case .full:
                buttonAlpha = 1.0
                labelAlpha = 0.0
                imageView.image = UIImage(named: "bin-full")!.withRenderingMode(.alwaysTemplate)
            case .empty:
                buttonAlpha = 0.0
                labelAlpha = 1.0
                imageView.image = UIImage(named: "bin-empty")!.withRenderingMode(.alwaysTemplate)
                clearedLabel.text = "Clipboard is empty"
            case .cleared:
                buttonAlpha = 0.0
                labelAlpha = 1.0
                imageView.image = UIImage(named: "bin-empty")!.withRenderingMode(.alwaysTemplate)
                clearedLabel.text = "Cleared!"
        }

        func closure() {
            clearClipboardButton.alpha = buttonAlpha
            clearedLabel.alpha = labelAlpha
        }

        if animated {
            UIView.animate(withDuration: Constants.AnimationDuration, animations: closure)

            let transition = CATransition()
            transition.duration = Constants.AnimationDuration
            transition.type = CATransitionType.fade
            imageView.layer.add(transition, forKey: nil)
        }
        else {
            closure()
        }
    }
}
