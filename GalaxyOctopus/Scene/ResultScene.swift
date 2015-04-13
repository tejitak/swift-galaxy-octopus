//
//  ResultScene.swift
//  GalaxyOctopus
//
//  Created by Takuya Tejima on 2015/04/12.
//  Copyright (c) 2015年 Takuya Tejima. All rights reserved.
//

import SpriteKit

class ResultScene: SKScene {
    
    override func didMoveToView(view: SKView) {
        
        // retrieve score and high score
        let ud = NSUserDefaults.standardUserDefaults()
        var score = ud.integerForKey("score")
        var hi_score = ud.integerForKey("hi_score")
        
        // show score
        let scoreLabel = SKLabelNode(fontNamed:"Copperplate")
        scoreLabel.text = "SCORE:\(score)";
        scoreLabel.fontSize = 72;
        scoreLabel.position = CGPoint(x:CGRectGetMidX(self.frame), y:CGRectGetMidY(self.frame));
        self.addChild(scoreLabel)
        
        
        if score > hi_score {
            ud.setInteger(score, forKey: "hi_score")
            hi_score = score
        }
        
        // show high score
        let hiLabel = SKLabelNode(fontNamed:"Copperplate")
        hiLabel.text = "ハイスコア:\(hi_score)";
        hiLabel.fontSize = 36;
        hiLabel.position = CGPoint(x:CGRectGetMidX(self.frame), y:CGRectGetMidY(self.frame)-100);
        self.addChild(hiLabel)
        
        // back button
//        let backLabel = SKLabelNode(fontNamed: "Copperplate")
//        backLabel.text = "Back"
//        backLabel.fontSize = 36
//        backLabel.position = CGPoint(x: CGRectGetMidX(self.frame), y: 200)
//        backLabel.name = "Back"
//        self.addChild(backLabel)
    }
    
    override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
        
        let touch: AnyObject! = touches.anyObject()
        let location = touch.locationInNode(self)
        let touchedNode = self.nodeAtPoint(location)
        
//        if touchedNode.name != nil {
//            if touchedNode.name == "Back" {
        
                let newScene = TitleScene(size: self.scene!.size)
                newScene.scaleMode = SKSceneScaleMode.AspectFill
                self.view!.presentScene(newScene)
//            }
//        }
    }
    
    override func update(currentTime: CFTimeInterval) {
        
    }
}