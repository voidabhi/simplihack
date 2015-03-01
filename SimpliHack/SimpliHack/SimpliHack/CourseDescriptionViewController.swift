//
//  CourseDescriptionViewController.swift
//  SimpliHack
//
//  Created by Alvin Varghese on 28/Feb/15.
//  Copyright (c) 2015 SimpliLearn. All rights reserved.
//

import UIKit

class CourseDescriptionViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    
    var arrayOfCourses : [String] = []
    var indexValue : Int = 6
    @IBOutlet var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.swipedOnViewActivated()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func swipedOnViewActivated()
    {
        NSURLConnection(request: NSURLRequest(URL: NSURL(string: "http://idreamcode.com/did/q/u/6".stringByAddingPercentEscapesUsingEncoding(NSUTF8StringEncoding)!)!), delegate: self, startImmediately: true)
    }
    
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int // Default is 1 if not implemented
    {
        return 1
    }
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return self.arrayOfCourses.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        let cell = self.tableView.dequeueReusableCellWithIdentifier("QeustionsCellQuestions", forIndexPath: indexPath) as ForQuestionsTableViewCell
        
        cell.questionsLabel.text = self.arrayOfCourses[indexPath.row]
        
        return cell
    }
    
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath)
    {
        var nextpageVC = Utilities.sharedInstance.getViewController("QuestionsAskingPage", MainType: "Main") as QuestionPageViewController
        
        nextpageVC.indexPathValue = indexPath.row
        nextpageVC.question = self.arrayOfCourses[indexPath.row]
        self.presentViewController(nextpageVC, animated: true, completion: nil)
        
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
                            
                            if index == jsonResult.count - 1
                            {
                                self.reloadTableView(titleArray)
                            }
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
    
    
    func reloadTableView(titleArray : [String])
    {
      self.arrayOfCourses = titleArray
        self.tableView.reloadData()
    }
    
    //MARK: Motion Shake Method
    
    
    override func canBecomeFirstResponder() -> Bool {
        return true
    }
    var flagForDoubleCheck : Bool =  false

    override func prefersStatusBarHidden() -> Bool {
        return true
    }
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

                  //  UIApplication.sharedApplication().openURL(NSURL(string: "facetime://00447947880666")!)
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
    
    
    @IBAction func backButtonClicked(sender: UIButton)
    {
        
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
}







