//
//  TodayViewController.swift
//  TodayClearryExtension
//
//  Created by Dmytro Vorobiov on 22.04.16.
//  Copyright © 2016 dvor. All rights reserved.
//

import UIKit
import NotificationCenter

class TodayViewController: UIViewController, NCWidgetProviding {
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var clearButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()

        label.textColor = UIColor.whiteColor()
        clearButton.tintColor = UIColor.mainColor()

        updateUI()

        label.sizeToFit()
        clearButton.sizeToFit()
        preferredContentSize.width = max(label.frame.size.width, clearButton.frame.size.width)
        preferredContentSize.height = max(label.frame.size.height, clearButton.frame.size.height)
    }

    func widgetPerformUpdateWithCompletionHandler(completionHandler: ((NCUpdateResult) -> Void)) {
        updateUI()
        completionHandler(NCUpdateResult.NewData)
    }

    func widgetMarginInsetsForProposedMarginInsets(defaultMarginInsets: UIEdgeInsets) -> UIEdgeInsets {
        return UIEdgeInsets(top: 5.0, left: 0.0, bottom: 5.0, right: 0.0)
    }

    @IBAction func clearButtonPressed(sender: AnyObject) {
        UIPasteboard.generalPasteboard().items = [AnyObject]()

        label.text = "Cleared!"
        label.hidden = false
        clearButton.hidden = true
    }

    func updateUI() {
        let isEmpty = UIPasteboard.generalPasteboard().items.count == 0

        label.text = "Clipboard is empty"
        label.hidden = !isEmpty
        clearButton.hidden = isEmpty
    }
}
