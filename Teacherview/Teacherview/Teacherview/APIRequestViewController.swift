//
//  APIRequestViewController.swift
//  Teacherview
//
//  Created by Alvin Varghese on 1/Mar/15.
//  Copyright (c) 2015 SimpliLearn. All rights reserved.
//

import UIKit

class APIRequestViewController: UIViewController, UITextFieldDelegate, UITextViewDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func backButtonClicked(sender: AnyObject)
    {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBOutlet var quetionField: UITextView!
    
     func textViewDidBeginEditing(textView: UITextView)
     {
    
    self.view.endEditing(true)
    }

    func textViewDidEndEditing(textView: UITextView) {
        self.view.endEditing(true)

    }

    @IBOutlet var keywordsField: UITextField!
    
    @IBAction func submitQuestionClicked(sender: UIButton)
    {
        let request = NSMutableURLRequest(URL: NSURL(string: "http://idreamcode.com/did/q/add")!)
        request.HTTPMethod = "POST"
        let postString = "courseid=6&title=\(self.quetionField.text)&keywords=\(self.keywordsField.text)"
        request.HTTPBody = postString.dataUsingEncoding(NSUTF8StringEncoding)
        let task = NSURLSession.sharedSession().dataTaskWithRequest(request) {
            data, response, error in
            
            if error != nil {
                println("error=\(error)")
                return
            }
            
            
            if let HTTPResponse = response as? NSHTTPURLResponse {
                let statusCode = HTTPResponse.statusCode
                
                if statusCode == 200 {
                    println(statusCode)
                }
            }
            
            // let responseString = NSString(data: data, encoding: NSUTF8StringEncoding)
        }
        task.resume()
        
    }
    
    
     func textFieldShouldReturn(textField: UITextField) -> Bool // called when 'return' key pressed. return NO to ignore.
     {
        self.view.endEditing(true)
        return true
        }

}
