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
        var startAcc = 0.0
        var startTime = NSDate()
        var endTime = NSDate()
        let motionManager = AppDelegate.Motion.Manager
        var freeFall = false
        var rotation = 0.0
        var acc = UILabel(frame: CGRectMake(view.bounds.midX, view.bounds.midY, 200, 100))
        var time = UILabel(frame: CGRectMake(view.bounds.midX, view.bounds.midY, 200, 100))
        time.center = CGPoint(x: view.bounds.midX + 50, y: view.bounds.midY)
        time.text = "0"
        time.backgroundColor = UIColor.whiteColor()
        time.textColor = UIColor.blackColor()
        self.view.addSubview(time)
        acc.center = CGPoint(x: view.bounds.midX, y: view.bounds.midY)
        acc.text = "\(startAcc)"
        acc.backgroundColor = UIColor.whiteColor()
        acc.textColor = UIColor.blackColor()
        self.view.addSubview(acc)
        
        if motionManager.accelerometerAvailable{
            motionManager.accelerometerUpdateInterval = 0.01
            motionManager.startAccelerometerUpdatesToQueue(NSOperationQueue.mainQueue()){(data, error)->Void
            in
                startAcc = sqrt(pow(((data?.acceleration.x)!),2.0) + pow(((data?.acceleration.y)!),2.0) + pow(((data?.acceleration.z)!),2.0))
               
                acc.text = "\(startAcc)"
                
                
                if startAcc > 9.5 && startAcc < 10.2 && !freeFall{
                   
                    startTime = NSDate()
                    freeFall = true
                    if motionManager.gyroAvailable{
                        rotation = (motionManager.gyroData?.rotationRate.y)!
                    }
                }
                if startAcc > 15 && freeFall{
                    endTime = NSDate()
                    let timeInterval: Double = endTime.timeIntervalSinceDate(startTime)
                    your_flip = Int(round(rotation*timeInterval))
                }
                
            
            
            }
        }
        
        while correct_flip == your_flip{
            correct_flip = Int((arc4random_uniform(20)+1)/2)
            
        }
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    /*
    func didFlip(manager : CMMotionManager) -> Bool {
        if manager.accelerometerAvailable{
            
        }
    }
*/

}

