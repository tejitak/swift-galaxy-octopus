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
        left = 1,
        up = 2,
        down = 3
    }
    
    // init states
    var score: Int = 0
    let countLabel = SKLabelNode(fontNamed:"Copperplate")
    var gameStatus: Int = GameStatus.kGamePlaying.rawValue
    var player: OctopusNode?
    var playerW: CGFloat = 0
    var playerH: CGFloat = 0
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
        self.playerW = self.frame.size.width / 8
        self.playerH = self.frame.size.height / 16
        self.player = OctopusNode(texture: nil, color: nil, size: CGSize(width: self.playerW, height: self.playerH))
        addPlayer()
        
        let swipeRight:UISwipeGestureRecognizer = UISwipeGestureRecognizer(target: self, action: Selector("swipedRight:"))
        swipeRight.direction = .Right
        view.addGestureRecognizer(swipeRight)
        
        let swipeLeft:UISwipeGestureRecognizer = UISwipeGestureRecognizer(target: self, action: Selector("swipedLeft:"))
        swipeLeft.direction = .Left
        view.addGestureRecognizer(swipeLeft)
        
        let swipeUp:UISwipeGestureRecognizer = UISwipeGestureRecognizer(target: self, action: Selector("swipedUp:"))
        swipeUp.direction = .Up
        view.addGestureRecognizer(swipeUp)
        
        let swipeDown:UISwipeGestureRecognizer = UISwipeGestureRecognizer(target: self, action: Selector("swipedDown:"))
        swipeDown.direction = .Down
        view.addGestureRecognizer(swipeDown)
        
        countLabel.text = "\(score)"
        countLabel.fontSize = 40
        countLabel.position = CGPoint(x:CGRectGetMidX(self.frame), y:self.size.height - countLabel.frame.height * 2)
        self.addChild(countLabel)
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
    }
    
    func countUp() {
        score++
        countLabel.text = "\(score)"
    }
    
    func addPlayer() {
        if let p = self.player {
            p.position = CGPoint(x: self.size.width/2, y: self.size.height/2)
            p.name = ObjectName.player.toString()
            p.physicsBody?.categoryBitMask = playerCategory
            p.physicsBody?.contactTestBitMask = meteorCategory
            var pr: CGFloat = p.size.width / 4
            p.physicsBody = SKPhysicsBody(
                circleOfRadius: pr
            )
            self.addChild(p)
        }
    }
    
    
    func generateMeteor() {
        var dir: Int = Int(arc4random_uniform(UInt32(4)))
        var len: CGFloat = 0
        if dir == 0 || dir == 1 {
            len = self.size.height
        } else {
            len = self.size.width
        }
        var randLine: CGFloat = CGFloat(arc4random_uniform(UInt32(meteorLine)))
        let meteor: MeteorNode = MeteorNode()
        addMeteor(meteor, pos: len / CGFloat(meteorLine) * randLine , direction: dir)
    }
    
    func addMeteor(meteor: MeteorNode, pos: CGFloat, direction: Int) {
        if gameStatus != GameStatus.kGameOver.rawValue {
            var pr: CGFloat = meteor.size.width / 2
            meteor.physicsBody = SKPhysicsBody(
                circleOfRadius: pr
            )
            
            meteor.physicsBody?.contactTestBitMask = playerCategory
            meteor.physicsBody?.categoryBitMask = meteorCategory
            meteor.physicsBody?.collisionBitMask = playerCategory
            
            var moveX: CGFloat = self.size.width + meteor.size.width
            var moveY: CGFloat = self.size.height + meteor.size.height
            var rotate: SKAction
            var move: SKAction
            if direction == Direction.right.rawValue {
                rotate = SKAction.rotateByAngle(CGFloat(-M_PI * 2), duration: 2.0)
                move = SKAction.moveToX(moveX, duration: 2.0)
                meteor.position = CGPointMake(-meteor.size.width, pos)
            } else if direction == Direction.left.rawValue {
                rotate = SKAction.rotateByAngle(CGFloat(M_PI * 2), duration: 2.0)
                move = SKAction.moveToX(moveX * -1 + self.size.width, duration: 2.0)
                meteor.position = CGPointMake(self.size.width + meteor.size.width, pos)
            } else if direction == Direction.up.rawValue {
                rotate = SKAction.rotateByAngle(CGFloat(-M_PI * 2), duration: 2.0)
                move = SKAction.moveToY(moveY, duration: 2.0)
                meteor.position = CGPointMake(pos, -meteor.size.height)
            } else {
                // Direction.down.rawValue
                rotate = SKAction.rotateByAngle(CGFloat(M_PI * 2), duration: 2.0)
                move = SKAction.moveToY(moveY * -1 + self.size.height, duration: 2.0)
                meteor.position = CGPointMake(pos, self.size.height + meteor.size.height)
            }
            let count = SKAction.runBlock { self.countUp() }
            var action: SKAction = SKAction.sequence([[rotate, move, count], [SKAction.removeFromParent()]])
            meteor.runAction(action)
            self.addChild(meteor)
        }
    }
    
    func swipedRight(sender:UISwipeGestureRecognizer){
        if let p = self.player {
            let next = p.position.x - self.playerW
            if next > 0 {
                var diff: CGFloat = self.playerW
                var move: SKAction = SKAction.moveToX(next, duration: NSTimeInterval(diff / OctopusNode.NodeSettings.speed.rawValue))
                p.runAction(move)
            }
        }
    }
    
    func swipedLeft(sender:UISwipeGestureRecognizer){
        if let p = self.player {
            let next = p.position.x + self.playerW
            if next < self.frame.size.width {
                var diff: CGFloat = self.playerW
                var move: SKAction = SKAction.moveToX(next, duration: NSTimeInterval(diff / OctopusNode.NodeSettings.speed.rawValue))
                p.runAction(move)
            }
        }
    }
    
    func swipedUp(sender:UISwipeGestureRecognizer){
        if let p = self.player {
            let next = p.position.y - self.playerH
            if next > 0 {
                var diff: CGFloat = self.playerH
                var move: SKAction = SKAction.moveToY(next, duration: NSTimeInterval(diff / OctopusNode.NodeSettings.speed.rawValue))
                p.runAction(move)
            }
        }
    }
    
    func swipedDown(sender:UISwipeGestureRecognizer){
        if let p = self.player {
            let next = p.position.y + self.playerH
            if next < self.frame.size.height {
                var diff: CGFloat = self.playerH
                var move: SKAction = SKAction.moveToY(next, duration: NSTimeInterval(diff / OctopusNode.NodeSettings.speed.rawValue))
                p.runAction(move)
            }
        }
    }
}