//
//  GameScene.swift
//  GalaxyOctopus
//
//  Created by Takuya Tejima on 2015/04/12.
//  Copyright (c) 2015年 Takuya Tejima. All rights reserved.
//

import SpriteKit

class GameScene: SKScene, SKPhysicsContactDelegate {
    
    // game States
    enum GameStatus:Int {
        case kGamePlaying = 0,
        kGameOver
    }
    
    enum ObjectName {
        case player
        
        func toString()->String{
            switch self {
            case .player:
                return "End"
            }
        }
    }
    
    // object direction
    enum Direction: Int {
        case right = 0,
        left,
        up,
        down
    }
    
    // init states
    var score: Int = 0
    var gameStatus: Int = GameStatus.kGamePlaying.rawValue
    let player: OctopusNode = OctopusNode()
    var playerSpeed: CGFloat = OctopusNode.NodeSettings.speed.rawValue
    
    // collision category
    let playerCategory: UInt32 = 0x1<<0
    let meteorCategory: UInt32 = 0x1<<1
    
    // lines for meteor
    var meteorLine = 100
    
    // intervals
    var generateInterval: NSTimeInterval = 1
    var levelUpInterval: NSTimeInterval = 10
    
    // time cache
    var lastGenerateTime: NSTimeInterval = 0
    var lastLevelUpTime: NSTimeInterval = 0
    
    // stage lavel
    var level = 0
    let levelLabel = SKLabelNode(fontNamed:"Copperplate")
    
    override func didMoveToView(view: SKView) {
        // setup background
        var background : SKSpriteNode = SKSpriteNode (imageNamed: "background.png")
        background.position = CGPointMake(self.frame.size.width/2, self.frame.size.height/2)
        background.size = self.frame.size
        self.addChild(background)
        
        // setup phyical calculation
        self.physicsWorld.gravity = CGVectorMake(0, 0)
        self.physicsWorld.contactDelegate = self
        
        // initialize player
        addPlayer()
        
        levelLabel.text = "LEVEL:\(level)"
        levelLabel.fontSize = 40
        levelLabel.position = CGPoint(x:CGRectGetMidX(self.frame), y:self.size.height - levelLabel.frame.height * 2)
        self.addChild(levelLabel)
    }
    
    override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
        
        let touch: AnyObject! = touches.anyObject()
        let location = touch.locationInNode(self)
        
        var y: CGFloat = location.y
        var diff: CGFloat = abs(y - self.player.position.y)
        var move: SKAction = SKAction.moveToY(y, duration: NSTimeInterval(diff / OctopusNode.NodeSettings.speed.rawValue))
        self.player.runAction(move)
        
    }
    
    func didBeginContact(contact: SKPhysicsContact) {
        // detect collision
        gameOver()
    }
    
    override func update(currentTime: NSTimeInterval) {
        
        // meteor generate interval
        if lastGenerateTime + generateInterval < currentTime {
            generateMeteor()
            lastGenerateTime = currentTime
        }
        
        // level up interval
        if lastLevelUpTime + levelUpInterval * NSTimeInterval(level) < currentTime {
            levelUp()
            lastLevelUpTime = currentTime
        }
        
    }
    
    func gameOver() {
        // set scrore
        let ud = NSUserDefaults.standardUserDefaults()
        ud.setInteger(score, forKey: "score")
        
        // move to result scene
        let newScene = ResultScene(size: self.scene!.size)
        newScene.scaleMode = SKSceneScaleMode.AspectFill
        self.view!.presentScene(newScene)
    }
    
    func levelUp() {
        generateInterval *= 3/4
        level++
        levelLabel.text = "LEVEL:\(level)"
    }
    
    func addPlayer() {
        self.player.position = CGPoint(x: self.size.width/2, y: self.size.height/2)
        self.player.name = ObjectName.player.toString()
        self.player.physicsBody?.categoryBitMask = playerCategory
        self.player.physicsBody?.contactTestBitMask = meteorCategory
        var pr: CGFloat = self.player.size.width / 4
        self.player.physicsBody = SKPhysicsBody(
            circleOfRadius: pr
        )
        self.addChild(player)
    }
    
    
    func generateMeteor() {
        var randLine: CGFloat = CGFloat(arc4random_uniform(UInt32(meteorLine)))
        var randDirection: Int = Int(arc4random_uniform(UInt32(2)))
        addMeteor(self.size.height / CGFloat(meteorLine) * randLine , direction: randDirection)
    }
    
    func addMeteor(height: CGFloat, direction: Int) {
        if gameStatus != GameStatus.kGameOver.rawValue {
            score++
            
            let meteor: MeteorNode = MeteorNode()
            meteor.position = CGPointMake(-meteor.size.width, height)
            meteor.speed = MeteorNode.NodeSettings.speed.rawValue
            var pr: CGFloat = meteor.size.width / 2
            meteor.physicsBody = SKPhysicsBody(
                circleOfRadius: pr
            )
            
            meteor.physicsBody?.contactTestBitMask = playerCategory
            meteor.physicsBody?.categoryBitMask = meteorCategory
            meteor.physicsBody?.collisionBitMask = playerCategory
            
            var moveX: CGFloat = self.size.height
            var rotate: SKAction
            var move: SKAction
            if direction == Direction.right.rawValue {
                rotate = SKAction.rotateByAngle(CGFloat(-M_PI * 2), duration: 2.0)
                move = SKAction.moveToX(moveX, duration: 1.0)
            } else {
                rotate = SKAction.rotateByAngle(CGFloat(M_PI * 2), duration: 2.0)
                move = SKAction.moveToX(moveX * -1 + self.size.width, duration: 1.0)
                meteor.position.x = self.size.width + meteor.size.width
            }
            var action: SKAction = SKAction.sequence([[rotate, move], SKAction.removeFromParent()])
            meteor.runAction(action)
            self.addChild(meteor)
        }
    }
    
}