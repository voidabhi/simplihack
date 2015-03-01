//
//  SettingsViewController.swift
//  SimpliHack
//
//  Created by Alvin Varghese on 28/Feb/15.
//  Copyright (c) 2015 SimpliLearn. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {

    @IBOutlet var shibuImage: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.shibuImage.layer.cornerRadius = self.shibuImage.frame.size.width / 2

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
 
    @IBAction func energyLevelButtonClicked(sender: UIButton)
    {
        var nextpageVC = Utilities.sharedInstance.getViewController("HealthPageVC", MainType: "Main") as HealthDataViewController
        self.presentViewController(nextpageVC, animated: true, completion: nil)
    }

    //MARK: Motion Shake Method
    
    
    override func canBecomeFirstResponder() -> Bool {
        return true
    }
    override func prefersStatusBarHidden() -> Bool {
        return true
    }
    
    
    override func motionEnded(motion: UIEventSubtype, withEvent event: UIEvent)
    {
        switch  motion
        {
        case UIEventSubtype.MotionShake :
            
            var userDefaults : NSUserDefaults = NSUserDefaults.standardUserDefaults()
            
            if let value = userDefaults.boolForKey("CheckWhetherUserIsBlinDOrNots") as Bool?
            {
                if value
                {
                    UIApplication.sharedApplication().openURL(NSURL(string: "facetime://alvinvarghese@live.com")!)

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
