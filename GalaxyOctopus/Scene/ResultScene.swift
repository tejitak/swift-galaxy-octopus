//
//  ResultScene.swift
//  GalaxyOctopus
//
//  Created by Takuya Tejima on 2015/04/12.
//  Copyright (c) 2015年 Takuya Tejima. All rights reserved.
//

import SpriteKit

class ResultScene: SKScene {
    
    var score: Int = -1
    
    override func didMoveToView(view: SKView) {
        
        // retrieve score and high score
        let ud = NSUserDefaults.standardUserDefaults()
        var score = ud.integerForKey("score")
        var hi_score = ud.integerForKey("hi_score")
        
        // show score
        let scoreLabel = SKLabelNode(fontNamed:"Copperplate")
        scoreLabel.text = "SCORE: \(score)"
        scoreLabel.fontSize = 42
        scoreLabel.position = CGPoint(x:CGRectGetMidX(self.frame), y:CGRectGetMidY(self.frame))
        self.addChild(scoreLabel)
        
        
        if score > hi_score {
            ud.setInteger(score, forKey: "hi_score")
            hi_score = score
        }
        
        // show high score
        let hiLabel = SKLabelNode(fontNamed:"Copperplate")
        hiLabel.text = "HIGH SCORE: \(hi_score)"
        hiLabel.fontSize = 24
        hiLabel.position = CGPoint(x:CGRectGetMidX(self.frame), y:CGRectGetMidY(self.frame) - 100)
        self.addChild(hiLabel)
        
        var tweetBtn : SKSpriteNode = TweetBtn()
        tweetBtn.position = CGPoint(x:CGRectGetMidX(self.frame) - 60, y:CGRectGetMidY(self.frame) + 120)
        self.addChild(tweetBtn)

        var fbBtn : SKSpriteNode = FBBtn()
        fbBtn.position = CGPoint(x:CGRectGetMidX(self.frame) + 60, y:CGRectGetMidY(self.frame) + 120)
        self.addChild(fbBtn)
        
        self.score = score
    }
    
    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
        if let touch = touches.first as? UITouch {
            let location = touch.locationInNode(self)
            let touchedNode = self.nodeAtPoint(location)
            if touchedNode is TweetBtn {
                NSNotificationCenter.defaultCenter().postNotificationName("tweetNotification", object: nil, userInfo: ["score": self.score])
            }else if touchedNode is FBBtn {
                NSNotificationCenter.defaultCenter().postNotificationName("fbNotification", object: nil, userInfo: ["score": self.score])
            }else{
                let newScene = TitleScene(size: self.scene!.size)
                newScene.scaleMode = SKSceneScaleMode.AspectFill
                self.view!.presentScene(newScene)
            }
        }
    }
    
    override func update(currentTime: CFTimeInterval) {
        
    }
}