
//
//  Simplihack
//
//  Created by Alvin Varghese on 28/Feb/15.
//  Copyright (c) 2015 SimpliLearn. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    
    var  lastPoint : CGPoint!
    var  red : CGFloat!
    var  green : CGFloat!
    var  blue : CGFloat!
    var  brush : CGFloat!
    var  opacity : CGFloat!
    var  mouseSwiped : Bool!
    
    
    @IBOutlet var tempImageView: UIImageView!
    
    @IBOutlet var mainImage: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        self.red = 56.0/255.0
        self.green = 144.0/255.0
        self.blue = 1.0/255.0
        self.brush = 10.0
        self.opacity = 1.0
        
        
        // Do any additional setup after loading the view. // =
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    //MARK: Drawing Happens Here
    
    override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
        
        
        // Getting the Touches from the user
        
        self.mouseSwiped = false
        
        var touch : UITouch = touches.anyObject() as UITouch
        
        self.lastPoint = touch.locationInView(self.view)
    }
    
    
    override func touchesMoved(touches: NSSet, withEvent event: UIEvent) {
        
        
        self.mouseSwiped = true
        
        var touch : UITouch = touches.anyObject() as UITouch
        
        var currentPoint : CGPoint = touch.locationInView(self.view)
        
        UIGraphicsBeginImageContext(self.view.frame.size)
        self.tempImageView.image?.drawInRect(CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height))
        
        CGContextMoveToPoint(UIGraphicsGetCurrentContext(), self.lastPoint.x, self.lastPoint.y)
        CGContextAddLineToPoint(UIGraphicsGetCurrentContext(), currentPoint.x, currentPoint.y)
        CGContextSetLineCap(UIGraphicsGetCurrentContext(), kCGLineCapRound)
        CGContextSetLineWidth(UIGraphicsGetCurrentContext(), self.brush )
        CGContextSetRGBStrokeColor(UIGraphicsGetCurrentContext(), self.red, self.green, self.blue, 1.0)
        CGContextSetBlendMode(UIGraphicsGetCurrentContext(),kCGBlendModeNormal)
        
        CGContextStrokePath(UIGraphicsGetCurrentContext())
        self.tempImageView.image = UIGraphicsGetImageFromCurrentImageContext()
        self.tempImageView.alpha = self.opacity
        UIGraphicsEndImageContext()
        
        self.lastPoint = currentPoint
    }
    
    override func touchesEnded(touches: NSSet, withEvent event: UIEvent) {
        
        if !self.mouseSwiped
        {
            UIGraphicsBeginImageContext(self.view.frame.size)
            self.tempImageView.image?.drawInRect(CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height))
            CGContextSetLineCap(UIGraphicsGetCurrentContext(), kCGLineCapRound)
            CGContextSetLineWidth(UIGraphicsGetCurrentContext(), self.brush)
            CGContextSetRGBStrokeColor(UIGraphicsGetCurrentContext(), self.red, self.green, self.blue, opacity)
            CGContextMoveToPoint(UIGraphicsGetCurrentContext(), self.lastPoint.x, self.lastPoint.y)
            CGContextAddLineToPoint(UIGraphicsGetCurrentContext(), self.lastPoint.x, self.lastPoint.y)
            CGContextStrokePath(UIGraphicsGetCurrentContext())
            CGContextFlush(UIGraphicsGetCurrentContext())
            self.tempImageView.image = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()
        }
        
        UIGraphicsBeginImageContext(self.mainImage.frame.size)
        self.mainImage.image?.drawInRect(CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height), blendMode: kCGBlendModeNormal, alpha: 1.0)
        self.tempImageView.image?.drawInRect(CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height), blendMode: kCGBlendModeNormal, alpha: 1.0)
        self.mainImage.image = UIGraphicsGetImageFromCurrentImageContext()
        self.tempImageView.image = nil
        UIGraphicsEndImageContext()
    }
    override func prefersStatusBarHidden() -> Bool {
        return true
    }
    
    
    @IBAction func sendScribbledImageClicked(sender: UIButton)
    {
        UIGraphicsBeginImageContextWithOptions(self.mainImage.bounds.size, false, 0.0)
        
        self.mainImage.image?.drawInRect(CGRectMake(0, 0, self.mainImage.frame.size.width, self.mainImage.frame.size.height))
        var saveImage : UIImage = UIGraphicsGetImageFromCurrentImageContext()
        
        
        // Do something with the image here
        
        
    
        
        
      //  var manager : AFHTTPRequestOperationManager = AFHTTPRequestOperationManager()
       // manager.POST(NSURL(string: ""), parameters: <#AnyObject!#>, constructingBodyWithBlock: <#((AFMultipartFormData!) -> Void)!##(AFMultipartFormData!) -> Void#>, success: <#((AFHTTPRequestOperation!, AnyObject!) -> Void)!##(AFHTTPRequestOperation!, AnyObject!) -> Void#>, failure: <#((AFHTTPRequestOperation!, NSError!) -> Void)!##(AFHTTPRequestOperation!, NSError!) -> Void#>)
        
        
//        AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
//        
//        [manager POST:stringUrl parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData> formData)
//        {
//        [formData appendPartWithFileURL:filePath name:@"userfile" error:nil];//here userfile is a paramiter for your image
//        }
//        success:^(AFHTTPRequestOperation *operation, id responseObject)
//        {
//        NSLog(@"%@",[responseObject valueForKey:@"Root"]);
//        Alert_Success_fail = [[UIAlertView alloc] initWithTitle:@"myappname" message:string delegate:self cancelButtonTitle:@"ok" otherButtonTitles:nil, nil];
//        [Alert_Success_fail show];
//        
//        }
//        failure:^(AFHTTPRequestOperation *operation, NSError *error)
//        {
//        Alert_Success_fail = [[UIAlertView alloc] initWithTitle:@"myappname" message:[error localizedDescription] delegate:self cancelButtonTitle:@"ok" otherButtonTitles:nil, nil];
//        [Alert_Success_fail show];
//        
//        }];
//        
    }
    
    @IBAction func closeButton(sender: UIButton)
    {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
}










