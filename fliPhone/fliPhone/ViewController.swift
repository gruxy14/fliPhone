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

       
        var correct_flip = 0
        var your_flip = 0
        var startAcc = 0.0
        var startTime = NSDate()
        var endTime = NSDate()
        let motionManager = AppDelegate.Motion.Manager
        var freeFall = false
        var rotation = 0.0
        var acc = UILabel(frame: CGRectMake(view.bounds.midX, view.bounds.midY, 50, 50))
        var time = UILabel(frame: CGRectMake(view.bounds.midX, view.bounds.midY, 50, 50))
        time.center = CGPoint(x: view.bounds.midX + 50, y: view.bounds.midY)
        time.text = "0"
        time.backgroundColor = UIColor.whiteColor()
        time.textColor = UIColor.blackColor()
        self.view.addSubview(time)
        acc.center = CGPoint(x: view.bounds.midX-50, y: view.bounds.midY)
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
                
                
                if startAcc > -0.7 && startAcc < 0.7 && !freeFall{
                   
                    startTime = NSDate()
                    freeFall = true
                    //if motionManager.gyroAvailable{
                      //  rotation = (motionManager.gyroData?.rotationRate.y)!
                    //}
                }
                if startAcc > 2 && freeFall{
                    endTime = NSDate()
                    let timeInterval: Double = endTime.timeIntervalSinceDate(startTime)
                    time.text = "\(timeInterval)"
                    your_flip = Int(round(rotation*timeInterval))
                }
                
            
            
            }
        }

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
    
    /*
    func didFlip(manager : CMMotionManager) -> Bool {
        if manager.accelerometerAvailable{
            
        }
    }
*/

}

