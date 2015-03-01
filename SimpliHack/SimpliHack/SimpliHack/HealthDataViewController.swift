//
//  HealthDataViewController.swift
//  SimpliHack
//
//  Created by Alvin Varghese on 28/Feb/15.
//  Copyright (c) 2015 SimpliLearn. All rights reserved.
//

import UIKit
import HealthKit

class HealthDataViewController: UIViewController {
    
    let healthManager : HealthManager = HealthManager()

    let healthKitStore : HKHealthStore = HKHealthStore()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.authorizeHealthKit()

    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func prefersStatusBarHidden() -> Bool {
        return true
    }
    func healthDataAnalysis()
    {
        var barChart : PNBarChart = PNBarChart(frame: CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height ))
          barChart.backgroundColor = UIColor.clearColor()
        barChart.animationType = .Waterfall
        
        barChart.xLabels = ["Temprature","Pulse","Sleepiness"]
        barChart.yValues = [36,76,12]
        barChart.strokeChart()
        self.view.addSubview(barChart)
        
        
        
        var swipeGesture : UISwipeGestureRecognizer =  UISwipeGestureRecognizer(target: self, action: Selector("swipedOnViewActivated:"))
        swipeGesture.direction = UISwipeGestureRecognizerDirection.Up
        self.view.addGestureRecognizer(swipeGesture)
        
    }
    
    func swipedOnViewActivated(gesture : UISwipeGestureRecognizer)
    {
        
        self.dismissViewControllerAnimated(true, completion: nil)
        
    }

    

    func authorizeHealthKit()
    {
        healthManager.authorizeHealthKit { (authorized,  error) -> Void in
            if authorized {
                
                dispatch_async(dispatch_get_main_queue(),  {
                
                    self.healthDataAnalysis()
                })
            }
            else
            {
                Utilities.sharedInstance.alertThis("Sorry :(", message: "Permission denied")
                
                if error != nil {
                    println("\(error)")
                }
            }
        }
    }
    
   
    
    //MARK: Motion Shake Method
    
    
    override func canBecomeFirstResponder() -> Bool {
        return true
    }
    
    var flagForDoubleCheck : Bool =  false

    override func motionEnded(motion: UIEventSubtype, withEvent event: UIEvent)
    {
        switch  motion
        {
        case UIEventSubtype.MotionShake :
            
            var userDefaults : NSUserDefaults = NSUserDefaults.standardUserDefaults()
            
            if let value = userDefaults.boolForKey("CheckWhetherUserIsBlinDOrNot") as Bool?
            {
                if value
                {
                    if flagForDoubleCheck
                    {
                        UIApplication.sharedApplication().openURL(NSURL(string: "facetime://alvinvarghese@live.com")!)
                        
                        self.flagForDoubleCheck =  false
                        
                    }
                    else
                    {
                        UIApplication.sharedApplication().openURL(NSURL(string: "facetime://")!)
                        self.flagForDoubleCheck =  true
                        
                    }
                   // UIApplication.sharedApplication().openURL(NSURL(string: "facetime://00447947880666")!)
                }
                else
                {
                    var nextpageVC = Utilities.sharedInstance.getViewController("ScribblingPage", MainType: "Main") as ViewController
                    self.presentViewController(nextpageVC, animated: true, completion: nil)
                }
            }
            
        default : println("do nothing")
            
        }
    }
    
}
