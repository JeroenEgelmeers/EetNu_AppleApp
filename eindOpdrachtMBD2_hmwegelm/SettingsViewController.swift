//
//  SettingsViewController.swift
//  eindOpdrachtMBD2_hmwegelm
//
//  Created by User on 13/04/15.
//  Copyright (c) 2015 hmwegelm2060058. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {
    
    @IBOutlet weak var settingsValue: UISegmentedControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setSettings(0)
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func changeSettings(sender: UISegmentedControl) {
        self.settingsValue = sender
        setSettings(settingsValue.selectedSegmentIndex)
    }
    
    func setSettings(value: Int) {
        let defaults = NSUserDefaults.standardUserDefaults()
        defaults.setObject(value, forKey: "settings")
        defaults.synchronize()
        NSNotificationCenter.defaultCenter().postNotificationName("load", object: nil)
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
