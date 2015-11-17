//
//  ViewController.swift
//  fliPhone
//
//  Created by Grant Costa on 11/17/15.
//  Copyright © 2015 Grant Costa. All rights reserved.
//

import UIKit
import CoreMotion

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    @IBAction func beginFlip(sender: UIButton) {
        var correct_flip = 0
        var your_flip = 0
        while correct_flip == your_flip{
            correct_flip = Int((arc4random_uniform(20)+1)/2)
            
        }
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

