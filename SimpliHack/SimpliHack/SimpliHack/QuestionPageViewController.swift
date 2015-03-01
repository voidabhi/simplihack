//
//  QuestionPageViewController.swift
//  SimpliHack
//
//  Created by Alvin Varghese on 28/Feb/15.
//  Copyright (c) 2015 SimpliLearn. All rights reserved.
//

import UIKit

class QuestionPageViewController: UIViewController, UITextFieldDelegate {

    
    
    @IBOutlet var answerView: UIView!
    
    @IBOutlet var questionField: UITextView!
    
    @IBOutlet var keywordsField: UITextField!
    
    @IBOutlet var postQuestion: UIButton!
    
    
    
    @IBOutlet var yourScoreOutlet: UILabel!
    
    @IBOutlet var yourMarksOutlet: UILabel!
    
    
    var indexPathValue = 0
    var question : String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // At starting hide the answerView
        
        self.answerView.hidden = true

        
        self.questionField.layer.cornerRadius = 10
        self.keywordsField.layer.cornerRadius = 10
        self.postQuestion.layer.cornerRadius = 10
        
        self.answerView.layer.cornerRadius = 15

        self.questionField.text = self.question
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func prefersStatusBarHidden() -> Bool {
        return true
    }

     func textFieldShouldReturn(textField: UITextField) -> Bool // called when 'return' key pressed. return NO to ignore.
     {
        self.view.endEditing(true)
        
        return true
     }
    
    @IBAction func postQuestionClicked(sender: UIButton)
    {
        // Post question to forum
        
        // After Processing the request
        // Show whether the anser is correct or not
        
        // Put the view in center
        
        self.answerView.hidden = false
        self.answerView.center = self.view.center
        self.view.addSubview(self.answerView)
    }
    
    
    @IBAction func backButtonClicked(sender: UIButton)
    {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
}
