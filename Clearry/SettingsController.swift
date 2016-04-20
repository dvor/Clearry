//
//  SettingsController.swift
//  Clearry
//
//  Created by Dmytro Vorobiov on 20.04.16.
//  Copyright © 2016 dvor. All rights reserved.
//

import UIKit

class SettingsController: UIViewController {
    @IBOutlet weak var doneButton: UIBarButtonItem!
    @IBOutlet weak var automaticallyCleanSwitch: UISwitch!

    override func viewDidLoad() {
        super.viewDidLoad()

        setupViews()
    }

    override func prefersStatusBarHidden() -> Bool {
        return true
    }

    @IBAction func doneButtonPressed(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
    }

    @IBAction func automaticallyCleanSwitchChanged(sender: AnyObject) {
        UserDefaults().automaticallyClean = automaticallyCleanSwitch.on
    }
}

private extension SettingsController {
    func setupViews() {
        doneButton.tintColor = UIColor.mainColor()

        automaticallyCleanSwitch.onTintColor = UIColor.mainColor()
        automaticallyCleanSwitch.on = UserDefaults().automaticallyClean
    }
}
