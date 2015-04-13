//
//  TitleScene.swift
//  GalaxyOctopus
//
//  Created by Takuya Tejima on 2015/04/12.
//  Copyright (c) 2015年 Takuya Tejima. All rights reserved.
//

import SpriteKit

class TitleScene: SKScene {
    
    override func didMoveToView(view: SKView) {
        
        // show title label
        let myLabel = SKLabelNode(fontNamed:"Chalkduster")
        myLabel.text = "Swipe on Screen to Avoid Action!!"
        myLabel.fontSize = 48
        myLabel.position = CGPoint(x:CGRectGetMidX(self.frame), y:CGRectGetMidY(self.frame))
        self.addChild(myLabel)
        
        // show start label
//        let startLabel = SKLabelNode(fontNamed: "Copperplate")
//        startLabel.text = "Start!"
//        startLabel.fontSize = 36
//        startLabel.position = CGPoint(x: CGRectGetMidX(self.frame), y: 200)
//        startLabel.name = "Start"
//        self.addChild(startLabel)
    }
    
    override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
        
        let touch: AnyObject! = touches.anyObject()
        let location = touch.locationInNode(self)
        let touchedNode = self.nodeAtPoint(location)
        
        // move to GameScene by tapping start label
//        if touchedNode.name != nil {
//            if touchedNode.name == "Start" {
                let newScene = GameScene(size: self.scene!.size)
                newScene.scaleMode = SKSceneScaleMode.AspectFill
                self.view!.presentScene(newScene)
//            }
//        }
    }
    
    override func update(currentTime: CFTimeInterval) {
        
    }
}
