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

    @IBOutlet weak var flips: UIButton!
    @IBOutlet weak var currentScore: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        flips.setTitle("Click to Start", forState: UIControlState.Normal)
        flips.backgroundColor = (UIColor.yellowColor())
        // Do any additional setup after loading the view, typically from a nib.
    }

    @IBAction func beginFlip(sender: UIButton) {
        var correctFlip = 0
        var yourFlip = 0
        while correctFlip == yourFlip{
            correctFlip = Int((arc4random_uniform(9)+1))
            flips.setTitle(String(correctFlip), forState: UIControlState.Normal)
            flips.titleLabel!.font = UIFont(name: "System", size: 30)
            //sleep(2)
        }
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

