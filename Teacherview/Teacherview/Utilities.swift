//
//  Utilities.swift
//  Dictionary
//
//  Created by Alvin Varghese on 19/Nov/14.
//  Copyright (c) 2014 Karky Research Foundation. All rights reserved.
//

import UIKit


class Utilities: NSObject, UIAlertViewDelegate {
   
    //MARK: - Creating sharedInstance

    class var sharedInstance: Utilities {
            
            struct Static {
                
                static var sharedInstance: Utilities?
                static var token: dispatch_once_t = 0
            }
            
            dispatch_once(&Static.token) {
                Static.sharedInstance = Utilities()
            }
            
            return Static.sharedInstance!
    }
    
    
    //MARK: Getting UIViewController from UIStoryboard 
    
    
    func getViewController(fromStroyBoardVC : String, MainType : String) -> UIViewController
    {
        var mainStoryBoard : UIStoryboard = UIStoryboard(name: MainType, bundle: nil)
        var viewControllerID : UIViewController = mainStoryBoard.instantiateViewControllerWithIdentifier(fromStroyBoardVC) as UIViewController
        
        return viewControllerID
    }
    
    //MARK: - Finding the Language of a String
    
    func languageOfString(tempString : NSString) -> NSString
    {
        var tagSchemes : NSArray = NSArray(object: NSLinguisticTagSchemeLanguage)
        var tagger : NSLinguisticTagger = NSLinguisticTagger(tagSchemes: tagSchemes, options: 0)
        tagger.string = tempString
        
        
        if let language = tagger.tagAtIndex(0, scheme: NSLinguisticTagSchemeLanguage, tokenRange: nil, sentenceRange: nil) as NSString? {
            
            return language
        }
        else
        {
            return "nil"
        }
    }
    

    //MARK: - alertViewforall
    
    func alertThis(title : NSString, message : NSString)
    {
        var alertView : UIAlertView = UIAlertView()
        alertView.delegate = self
        alertView.title = "\(title)"
        alertView.message = "\(message)"
        alertView.addButtonWithTitle("சரி")
        alertView.show()
    }
    
    //MARK: - Under Lining A UILabel

    func underLineThisLabel(label : UILabel, stringValue : String)
    {
        var attributeString : NSMutableAttributedString = NSMutableAttributedString(string: stringValue)
        attributeString.addAttribute(NSUnderlineStyleAttributeName, value: NSUnderlineStyle.StyleSingle.rawValue, range: NSMakeRange(0, attributeString.length))
        
        label.attributedText = attributeString
    }
    
    //MARK: - Opening a URL in website or in itunes or in settings

    func openAURL(url : String)
    {
        UIApplication.sharedApplication().openURL(NSURL(string: url)!)

    }
    
    //MARK: - Opening a Settings Page

    func openSettingsPage()
    {
         UIApplication.sharedApplication().openURL(NSURL(string: UIApplicationOpenSettingsURLString)!)
    }
    
    
    //MARK: - Device Details

    func deviceDetails() -> (name : String, systemVersion : String, systemName : String, model : String, localizedModel : String, userInterFaceIdiom : UIUserInterfaceIdiom, identifierForVendor : NSUUID)
    {
        return (UIDevice.currentDevice().name, UIDevice.currentDevice().systemVersion, UIDevice.currentDevice().systemName, UIDevice.currentDevice().model, UIDevice.currentDevice().localizedModel, UIDevice.currentDevice().userInterfaceIdiom, UIDevice.currentDevice().identifierForVendor)
    }
}





