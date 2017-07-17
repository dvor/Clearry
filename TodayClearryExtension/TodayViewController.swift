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

        label.textColor = UIColor.white
        clearButton.tintColor = UIColor.mainColor()

        updateUI()

        label.sizeToFit()
        clearButton.sizeToFit()
        preferredContentSize.width = max(label.frame.size.width, clearButton.frame.size.width)
        preferredContentSize.height = max(label.frame.size.height, clearButton.frame.size.height)
    }

    func widgetPerformUpdate(completionHandler: (@escaping (NCUpdateResult) -> Void)) {
        updateUI()
        completionHandler(NCUpdateResult.newData)
    }

    func widgetMarginInsets(forProposedMarginInsets defaultMarginInsets: UIEdgeInsets) -> UIEdgeInsets {
        return UIEdgeInsets(top: 5.0, left: 0.0, bottom: 5.0, right: 0.0)
    }

    @IBAction func clearButtonPressed(_ sender: AnyObject) {
        UIPasteboard.general.items = [AnyObject]() as! [[String : Any]]

        label.text = "Cleared!"
        label.isHidden = false
        clearButton.isHidden = true
    }

    func updateUI() {
        let isEmpty = UIPasteboard.general.items.count == 0

        label.text = "Clipboard is empty"
        label.isHidden = !isEmpty
        clearButton.isHidden = isEmpty
    }
}
