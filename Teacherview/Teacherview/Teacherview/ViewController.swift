//
//  ViewController.swift
//  Teacherview
//
//  Created by Alvin Varghese on 1/Mar/15.
//  Copyright (c) 2015 SimpliLearn. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    
        var barChart : PNBarChart = PNBarChart(frame: CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height ))
        barChart.backgroundColor = UIColor.clearColor()
        barChart.animationType = .Waterfall
        
        barChart.xLabels = ["Student 1","Student 2","Student 3"]
        barChart.yValues = [36,76,12]
        barChart.strokeChart()
        self.view.addSubview(barChart)
    
        var swipeGesture : UISwipeGestureRecognizer =  UISwipeGestureRecognizer(target: self, action: Selector("swipedOnViewActivated:"))
        swipeGesture.direction = UISwipeGestureRecognizerDirection.Up
        self.view.addGestureRecognizer(swipeGesture)
    
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func swipedOnViewActivated(gesture : UISwipeGestureRecognizer)
    {
        var nextpageVC = Utilities.sharedInstance.getViewController("QuestionsAskingPage", MainType: "Main") as APIRequestViewController
        self.presentViewController(nextpageVC, animated: true, completion: nil)
    }

}

