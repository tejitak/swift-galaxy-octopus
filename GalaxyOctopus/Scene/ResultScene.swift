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
        hiLabel.position = CGPoint(x:CGRectGetMidX(self.frame), y:CGRectGetMidY(self.frame)-100)
        self.addChild(hiLabel)
    }
    
    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
        if let touch = touches.first as? UITouch {
            let location = touch.locationInNode(self)
            let touchedNode = self.nodeAtPoint(location)
            let newScene = TitleScene(size: self.scene!.size)
            newScene.scaleMode = SKSceneScaleMode.AspectFill
            self.view!.presentScene(newScene)
        }
    }
    
    override func update(currentTime: CFTimeInterval) {
        
    }
}