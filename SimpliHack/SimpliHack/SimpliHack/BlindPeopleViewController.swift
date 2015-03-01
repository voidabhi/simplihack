//
//  BlindPeopleViewController.swift
//  SimpliHack
//
//  Created by Alvin Varghese on 28/Feb/15.
//  Copyright (c) 2015 SimpliLearn. All rights reserved.
//

import UIKit
import AVFoundation

class BlindPeopleViewController: UIViewController,AVAudioRecorderDelegate,AVAudioPlayerDelegate
{
    
    var  audioRecorder : AVAudioRecorder!
    var  audioPlayer : AVAudioPlayer!
    
    var flagForCheckingButtonState : Bool = false
    
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        
    }
    override func prefersStatusBarHidden() -> Bool {
        return true
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func recordWithPermission() {
        let session:AVAudioSession = AVAudioSession.sharedInstance()
        // ios 8 and later
        if (session.respondsToSelector("requestRecordPermission:")) {
            AVAudioSession.sharedInstance().requestRecordPermission({(granted: Bool)-> Void in
                if granted {
                    
                    self.setupRecorder()
                    
                } else {
                    println("Permission to record not granted")
                }
            })
        } else {
            println("requestRecordPermission unrecognized")
        }
    }
    
    @IBAction func recordButtonClicked(sender: AnyObject)
    {
        // Record Data
        
        self.recordWithPermission()
    }
    
    
    @IBAction func playButton(sender: UIButton)
    {
        self.stopRecording()
    }
    
    func setupRecorder()
    {
        var format = NSDateFormatter()
        format.dateFormat="yyyy-MM-dd-HH-mm-ss"
        var currentFileName = "recording-\(format.stringFromDate(NSDate())).m4a"
        println(currentFileName)
        
        var dirPaths = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)
        
        var docsDir: AnyObject = dirPaths[0]
        
        var soundFilePath = docsDir.stringByAppendingPathComponent(currentFileName)
        
        var soundFileURL : NSURL = NSURL(fileURLWithPath: soundFilePath)!
        
        let filemanager = NSFileManager.defaultManager()
        
        if filemanager.fileExistsAtPath(soundFilePath) {
            // probably won't happen. want to do something about it?
            println("sound exists")
        }
        
        AVAudioSession.sharedInstance().setCategory(AVAudioSessionCategoryPlayAndRecord, error: nil)
        
        var recordSettings = [
            AVFormatIDKey: kAudioFormatAppleLossless,
            AVEncoderAudioQualityKey : AVAudioQuality.Max.rawValue,
            AVEncoderBitRateKey : 320000,
            AVNumberOfChannelsKey: 2,
            AVSampleRateKey : 44100.0
        ]
        
        var error: NSError?
        self.audioRecorder =  AVAudioRecorder(URL: soundFileURL, settings: recordSettings, error: &error)
        self.audioRecorder.meteringEnabled = true
        self.audioRecorder.prepareToRecord() // creates/overwrites the file at soundFileURL
        self.audioRecorder.record()
    }
    
    
    func stopRecording()
    {
        self.audioRecorder.stop()
        
        self.audioPlayer = AVAudioPlayer(contentsOfURL: self.audioRecorder.url, error: nil)
        self.audioPlayer.delegate = self
        self.audioPlayer.play()
    }
    
    
}







