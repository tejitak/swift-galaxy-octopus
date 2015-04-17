//
//  GameViewController.swift
//  AvoidActionSample
//
//  Created by ALPEN on 2015/01/21.
//  Copyright (c) 2015年 alperithm. All rights reserved.
//

import UIKit
import SpriteKit
import Social

extension SKNode {
    class func unarchiveFromFile(file: String) -> SKNode? {
        if let path = NSBundle.mainBundle().pathForResource(file, ofType: "sks") {
            var sceneData = NSData(contentsOfFile: path, options: .DataReadingMappedIfSafe, error: nil)!
            var archiver = NSKeyedUnarchiver(forReadingWithData: sceneData)
            
            archiver.setClass(self.classForKeyedUnarchiver(), forClassName: "SKScene")
            let scene = archiver.decodeObjectForKey(NSKeyedArchiveRootObjectKey) as! TitleScene
            archiver.finishDecoding()
            return scene
        } else {
            return nil
        }
    }
}

class GameViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let scene = TitleScene.unarchiveFromFile("TitleScene") as? TitleScene {
            // Configure the view.
            let skView = self.view as! SKView
//            skView.showsFPS = true
//            skView.showsNodeCount = true
            
            /* Sprite Kit applies additional optimizations to improve rendering performance */
            skView.ignoresSiblingOrder = true
            
            /* Set the scale mode to scale to fit the window */
            scene.scaleMode = .AspectFill
            
            // set SKScene size to View  to prevent display scaling
            scene.size = skView.frame.size
            skView.presentScene(scene)
        }
        let nc = NSNotificationCenter.defaultCenter()
        nc.addObserver(self, selector: "showTweetSheet:", name: "tweetNotification", object: nil)
        nc.addObserver(self, selector: "showFBSheet:", name: "fbNotification", object: nil)

    }
    
    override func shouldAutorotate() -> Bool {
        return true
    }
    
    override func supportedInterfaceOrientations() -> Int {
        if UIDevice.currentDevice().userInterfaceIdiom == .Phone {
            return Int(UIInterfaceOrientationMask.AllButUpsideDown.rawValue)
        } else {
            return Int(UIInterfaceOrientationMask.All.rawValue)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Release any cached data, images, etc that aren't in use.
    }
    
    override func prefersStatusBarHidden() -> Bool {
        return true
    }
    
    func showTweetSheet(notification: NSNotification) {
        let userInfo:Dictionary<String, Int> = notification.userInfo as! Dictionary<String, Int>
        var score: Int = -1
        if let data = userInfo["score"] {
            score = data
        }
        let tweetSheet = SLComposeViewController(forServiceType: SLServiceTypeTwitter)
        tweetSheet.completionHandler = {
            result in
            switch result {
            case SLComposeViewControllerResult.Cancelled:
                //Add code to deal with it being cancelled
                break
                
            case SLComposeViewControllerResult.Done:
                //Add code here to deal with it being completed
                //Remember that dimissing the view is done for you, and sending the tweet to social media is automatic too. You could use this to give in game rewards?
                break
            }
        }
        print(score)
        tweetSheet.setInitialText("I got a score \(score)!! Galaxy Octopus #galaxy_octopus") //The default text in the tweet
        tweetSheet.addImage(UIImage(named: "app_icon.png")) //Add an image if you like?
        tweetSheet.addURL(NSURL(string: "https://itunes.apple.com/us/app/galaxy-octopus/id986836246?l=ja&ls=1&mt=8")) //A url which takes you into safari if tapped on
        
        self.presentViewController(tweetSheet, animated: false, completion: {
            //Optional completion statement
        })
    }
    
    func showFBSheet(notification: NSNotification) {
        let userInfo:Dictionary<String, Int> = notification.userInfo as! Dictionary<String, Int>
        var score: Int = -1
        if let data = userInfo["score"] {
            score = data
        }
        let fbSheet = SLComposeViewController(forServiceType: SLServiceTypeFacebook)
        fbSheet.completionHandler = {
            result in
            switch result {
            case SLComposeViewControllerResult.Cancelled:
                //Add code to deal with it being cancelled
                break
                
            case SLComposeViewControllerResult.Done:
                //Add code here to deal with it being completed
                //Remember that dimissing the view is done for you, and sending the tweet to social media is automatic too. You could use this to give in game rewards?
                break
            }
        }
        
        fbSheet.setInitialText("I got a score \(score)!! Galaxy Octopus") //The default text in the tweet
        fbSheet.addImage(UIImage(named: "app_icon.png")) //Add an image if you like?
        fbSheet.addURL(NSURL(string: "https://itunes.apple.com/us/app/galaxy-octopus/id986836246?l=ja&ls=1&mt=8")) //A url which takes you into safari if tapped on
        
        self.presentViewController(fbSheet, animated: false, completion: {
            //Optional completion statement
        })
    }
}
