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

    @IBAction func doneButtonPressed(_ sender: AnyObject) {
        dismiss(animated: true, completion: nil)
    }

    @IBAction func automaticallyCleanSwitchChanged(_ sender: AnyObject) {
        UserDefaults().automaticallyClean = automaticallyCleanSwitch.isOn
    }
}

private extension SettingsController {
    func setupViews() {
        doneButton.tintColor = UIColor.mainColor()

        automaticallyCleanSwitch.onTintColor = UIColor.mainColor()
        automaticallyCleanSwitch.isOn = UserDefaults().automaticallyClean
    }
}
