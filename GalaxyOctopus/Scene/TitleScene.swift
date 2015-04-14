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
        // setup background
        var background : SKSpriteNode = SKSpriteNode (imageNamed: "title")
        background.position = CGPointMake(self.frame.size.width/2, self.frame.size.height/2)
        background.size = self.frame.size
        self.addChild(background)

        // show title label
        let myLabel = SKLabelNode(fontNamed:"Courier")
        myLabel.text = "Just Swipe Octopus!"
        myLabel.fontSize = 20
        myLabel.position = CGPoint(x:CGRectGetMidX(self.frame), y: 90)
        self.addChild(myLabel)
    }
    
    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
        if let touch = touches.first as? UITouch {
            let location = touch.locationInNode(self)
            let touchedNode = self.nodeAtPoint(location)
            let newScene = GameScene(size: self.scene!.size)
            newScene.scaleMode = SKSceneScaleMode.AspectFill
            self.view!.presentScene(newScene)
        }
    }
    
    override func update(currentTime: CFTimeInterval) {
        
    }
}
