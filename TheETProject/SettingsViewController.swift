//
//  SettingsViewController.swift
//  TheETProject
//
//  Created by Belén Molina del Campo on 10/05/2016.
//  Copyright © 2016 Belén Molina del Campo. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {
    
    var place: Place!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func dismissViewController(sender: AnyObject) {
        
        self.dismissViewControllerAnimated(true) { () -> Void in
            print("updating settings")
        }
    }
    
}
