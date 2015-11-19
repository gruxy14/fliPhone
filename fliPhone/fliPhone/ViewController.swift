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
        var time = UILabel(frame: CGRectMake(view.bounds.midX, view.bounds.midY, 100, 50))
        var rot = UILabel(frame: CGRectMake(view.bounds.midX, view.bounds.midY, 100, 50))
        rot.center = CGPoint(x: view.bounds.midX - 50, y: view.bounds.midY + 20)
        rot.text = "0"
        rot.backgroundColor = UIColor.whiteColor()
        rot.textColor = UIColor.blackColor()
        self.view.addSubview(rot)
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
        var medianRotRate = Array<Double>()
        var countRot = false
        
        
        if motionManager.deviceMotionAvailable{
            motionManager.deviceMotionUpdateInterval = 0.03
            motionManager.startDeviceMotionUpdatesToQueue(NSOperationQueue.mainQueue()){(data, error)->Void
            in
                
                startAcc = sqrt(pow(((data?.userAcceleration.x)!),2.0) + pow(((data?.userAcceleration.y)!),2.0) + pow(((data?.userAcceleration.z)!),2.0))
                print("Total acc \(startAcc)")
                print("x acc: \((data?.userAcceleration.x)!)")
                print("y acc: \((data?.userAcceleration.y)!)")
                print("z acc: \((data?.userAcceleration.z)!)")
                print("x without g: \((data?.gravity.x)!)")
                print("y without g: \((data?.gravity.y)!)")
                print("z without g: \((data?.gravity.z)!)")
                
                acc.text = "\(startAcc)"
                
                
                rotation = (data?.rotationRate.y)!
                //print(rotation)
                if rotation > 2.0{
                    startTime = NSDate()
                    countRot = true
                    freeFall = true
                }
                if countRot{
                    medianRotRate.append(rotation)
                }
                
                if startAcc > 0.9 && startAcc < 1.1 && !freeFall{
                   
                    startTime = NSDate()
                    freeFall = true
                    //if motionManager.gyroAvailable{
                      //  rotation = (motionManager.gyroData?.rotationRate.y)!
                    //}
                }
                
                
                if (startAcc > 1.2 || startAcc < 0.8 || rotation < 0.5) && freeFall{
                    
                    endTime = NSDate()
                    let timeInterval: Double = endTime.timeIntervalSinceDate(startTime)
                    countRot = false
                    freeFall = false
                    //medianRotRate.sortInPlace()
                    //var median = medianRotRate.count/2
                    //rotation = medianRotRate[median]
                    
                    if timeInterval < 0.1 {
                        time.text = "Too short"
                        
                    }
                    else{
                    if startAcc < 1.5{
                        time.text = "Try again"
                        motionManager.stopDeviceMotionUpdates()
                    }
                    else{
                        time.text = "\(timeInterval)"
                        motionManager.stopDeviceMotionUpdates()
                    }
                    }
                    
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

