//
//  CoursesViewController.swift
//  SimpliHack
//
//  Created by Alvin Varghese on 28/Feb/15.
//  Copyright (c) 2015 SimpliLearn. All rights reserved.
//

import UIKit

class CoursesViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UIAlertViewDelegate {
    
    
    
    var arrayOfCoursesRecommended : [String] = []
    var arrayOfCoursesNotRecommended : [String] = []
    
    var idArray : [String] = []
    
    var indexPathValue : Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.requestData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    @IBOutlet var tableView: UITableView!
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int // Default is 1 if not implemented
    {
        return 2
    }

    override func prefersStatusBarHidden() -> Bool {
        return true
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        if section == 0
        {
            return self.arrayOfCoursesRecommended.count
        }
        else
        {
            return self.arrayOfCoursesNotRecommended.count
        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        let cell = self.tableView.dequeueReusableCellWithIdentifier("CorsesCell", forIndexPath: indexPath) as CoursesTableViewCell
        
        if indexPath.section == 0
        {
            cell.courseName.text = self.arrayOfCoursesRecommended[indexPath.row]
            cell.courseNames.image = UIImage(named: "")
            cell.courseName.textColor = UIColor.blackColor()
            cell.backgroundColor = UIColor(red: (241 / 255), green: (208 / 255), blue: (74 / 255), alpha: 1.0)
        }
        else
        {
            cell.courseName.text = self.arrayOfCoursesNotRecommended[indexPath.row]
            cell.courseNames.image = UIImage(named: "")
            cell.courseName.textColor = UIColor.whiteColor()

            cell.backgroundColor = UIColor(red: (200 / 255), green: (63 / 255), blue: (65 / 255), alpha: 1.0)

        }
            
        
        return cell
    }
    
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String?
    {
        if section == 0
        {
            return "Recommended Courses"
        }
        else
        {
            return "Not Recommended Courses"
        }
        
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath)
    {
        let cell = self.tableView.dequeueReusableCellWithIdentifier("CorsesCell", forIndexPath: indexPath) as CoursesTableViewCell
        
        self.indexPathValue = indexPath.row
        
        if indexPath.section == 0
        {
            var nextpageVC = Utilities.sharedInstance.getViewController("CourseDescriptionPage", MainType: "Main") as CourseDescriptionViewController
            self.presentViewController(nextpageVC, animated: true, completion: nil)
        }
        else
        {
            
            
            
            self.showAlert()
            
        }
    }
    


    func requestData()
    {
        NSURLConnection(request: NSURLRequest(URL: NSURL(string: "http://idreamcode.com/did/co/all".stringByAddingPercentEscapesUsingEncoding(NSUTF8StringEncoding)!)!), delegate: self, startImmediately: true)
    }
    
    
    
    //MARK: - NSURLConnection Delegate methods
    
    
    var responseData : NSMutableData = NSMutableData()
    var totalFileSize : Int = Int()
    var dataBytes : Int  = Int()
    
    func connection(connection: NSURLConnection!, didReceiveResponse response: NSURLResponse!)
    {
        self.responseData.length = 0
        totalFileSize = ( Int) (response.expectedContentLength)
    }
    
    func connection(connection: NSURLConnection!, didReceiveData data: NSData!)
    {
        dataBytes = data.length
        self.responseData.appendData(data)
        
    }
    
    
    func connectionDidFinishLoading(connection: NSURLConnection!)
    {
        var titleArray : [String] = []
        var enegyLevelValue : [String] = []
        var idArray : [String] = []
        
        
        if let responseDatas = responseData as NSData? {
            
            if let jsonResult : NSArray = NSJSONSerialization.JSONObjectWithData(responseDatas, options: NSJSONReadingOptions.MutableContainers, error: nil) as NSArray?
            {
                for index in 0..<jsonResult.count
                {
                    
                    if let arrayOfDictionary = jsonResult[index] as? NSDictionary
                    {
                        if let title = arrayOfDictionary.objectForKey("title") as? String
                        {
                            // Add it to an array of title
                            titleArray.append(title)
                        }
                        
                        if let energy = arrayOfDictionary.objectForKey("energy") as? String
                        {
                            // Add it to an array of Energy
                            enegyLevelValue.append(energy)
                        }
                        if let ids = arrayOfDictionary.objectForKey("id") as? String
                        {
                            // Add it to an array of Energy
                            idArray.append(ids)
                        }
                        
                        if index == jsonResult.count - 1
                        {
                            self.reloadTableView(titleArray, energyArray: enegyLevelValue, ids: idArray)
                        }
                    }
                }
                
            }
            else
            {
                // Data not getting - error
            }
        }
        else
        {
            // Server down
        }
    }
    
    func connection(connection: NSURLConnection!, didFailWithError error: NSError!)
    {
        Utilities.sharedInstance.alertThis("Error :(", message: "\(error.localizedDescription)")
    }
    
    
    func reloadTableView(titleArray : [String], energyArray : [String], ids : [String])
    {
        println(energyArray)
        
        for index in 0..<titleArray.count
        {
            if 7 > energyArray[index].toInt()
            {
                self.arrayOfCoursesRecommended.append(titleArray[index])
            }
            else
            {
                self.arrayOfCoursesNotRecommended.append(titleArray[index])
            }
        }
        
        self.idArray = ids
        self.tableView.reloadData()
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
            
            if let value = userDefaults.boolForKey("CheckWhetherUserIsBlinDOrNots") as Bool?
            {
                if value
                {
                    // UIApplication.sharedApplication().openURL(NSURL(string: "facetime://00447947880666")!)
                    
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
    
    func showAlert()
    {
        var alertView = UIAlertView()
        alertView.delegate = self
        alertView.title = "Hello There"
        alertView.message = "You energy level is too low, Listen to music for 5 minutes and come back!"
        alertView.addButtonWithTitle("Okay")
        alertView.addButtonWithTitle("Continue")
        alertView.show()
    }
    
    func alertView(alertView: UIAlertView, clickedButtonAtIndex buttonIndex: Int)
    {
        if buttonIndex == 0
        {
            var appDelegate : AppDelegate =  UIApplication.sharedApplication().delegate as AppDelegate
            UIApplication.sharedApplication().cancelAllLocalNotifications()
            appDelegate.activatingUserLocalNotification()
        }
        else
        {
            // Take them to the next page
            
            var nextpageVC = Utilities.sharedInstance.getViewController("CourseDescriptionPage", MainType: "Main") as CourseDescriptionViewController
            nextpageVC.indexValue = indexPathValue
            self.presentViewController(nextpageVC, animated: true, completion: nil)
        }
    }
}






