//
//  LoginViewViewController.swift
//  SimpliHack
//
//  Created by Alvin Varghese on 28/Feb/15.
//  Copyright (c) 2015 SimpliLearn. All rights reserved.
//

import UIKit

class LoginViewViewController: UIViewController, ServerRequet, UITextFieldDelegate {

    @IBOutlet var usernameField: UITextField!
    @IBOutlet var passwordField: UITextField!
    @IBOutlet var loginButtonOutlet: UIButton!
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        var userDefaults : NSUserDefaults = NSUserDefaults.standardUserDefaults()
        
        if let value = userDefaults.boolForKey("CheckWhetherUserIsBlinDOrNots") as Bool?
        {
            if value
            {                self.blindOutlet.setImage(UIImage(named: "tickMark"), forState: UIControlState.Normal)

                
            }
            else
            {
                
                self.blindOutlet.setImage(UIImage(named: "crossMark"), forState: UIControlState.Normal)

            }
        }
        

        self.usernameField.layer.cornerRadius = 10
        self.passwordField.layer.cornerRadius = 10
        self.loginButtonOutlet.layer.cornerRadius = 10
        
        CallingServer.sharedInstance.delegate = self
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
   

    @IBAction func loginButtonClicked(sender: UIButton)
    {
        CallingServer.sharedInstance.startFetching("http://idreamcode.com/did/s/u/\(self.usernameField.text)")
    }
    
    
    func finalResult(username: String, password: String)
    {
        if (self.usernameField.text == username) && (self.passwordField.text == password)
        {
            // Login Successful
            
            var nextpageVC = Utilities.sharedInstance.getViewController("tabBarpage", MainType: "Main")
            self.presentViewController(nextpageVC, animated: true, completion: nil)
        }
    }
    
     func textFieldShouldReturn(textField: UITextField) -> Bool // called when 'return' key pressed. return NO to ignore.
     {
        self.view.endEditing(true)
        return true
    }
    
    override func prefersStatusBarHidden() -> Bool {
        return true
    }
    
    @IBOutlet var checkForBlindPerson: UIButton!
    
    @IBAction func checkMarkForBlinDPerson(sender: UIButton)
    {
        var userDefaults : NSUserDefaults = NSUserDefaults.standardUserDefaults()
        
        if let value = userDefaults.boolForKey("CheckWhetherUserIsBlinDOrNots") as Bool?
        {
            if value
            {
                userDefaults.setBool(false, forKey: "CheckWhetherUserIsBlinDOrNots")
                self.blindOutlet.setImage(UIImage(named: "crossMark"), forState: UIControlState.Normal)
            }
            else
            {
                userDefaults.setBool(true, forKey: "CheckWhetherUserIsBlinDOrNots")
                self.blindOutlet.setImage(UIImage(named: "tickMark"), forState: UIControlState.Normal)
  
            }
        }
        userDefaults.synchronize()


        
    }
    
    @IBOutlet var blindOutlet: UIButton!
    
}
