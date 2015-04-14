//
//  MeteorNode.swift
//  GalaxyOctopus
//
//  Created by Takuya Tejima on 2015/04/12.
//  Copyright (c) 2015年 Takuya Tejima. All rights reserved.
//

import SpriteKit

class MeteorNode: SKSpriteNode {
    
    var spped: CGFloat = 0.2
    
    enum Meteor: Int {
        case slow = 0,
        normal = 1,
        fast = 2
        
        static func fromRaw(raw: Int) -> Meteor {
            switch raw {
            case 0:
                return .slow
            case 1:
                return .normal
            case 2:
                return .fast
            default:
                return .normal
            }
        }
        
        func getImage() -> String {
            switch self.rawValue {
            case 0:
                return "meteor_slow.png"
            case 1:
                return "meteor_normal.png"
            case 2:
                return "meteor_fast.png"
            default:
                return "meteor_normal.png"
            }
        }
        
        func getSpeed() -> CGFloat {
            switch self.rawValue {
            case 0:
                return 0.1
            case 1:
                return 0.2
            case 2:
                return 0.4
            default:
                return 0.2
            }
        }
    }
    
    override init(texture: SKTexture!, color: UIColor!, size: CGSize) {
        let ran: Int = Int(arc4random_uniform(UInt32(3)))
        let meteor = Meteor.fromRaw(ran)
        var t = SKTexture(imageNamed: meteor.getImage())
        super.init(texture: t, color: nil, size: CGSize(width: t.size().width / 4, height: t.size().height / 4))
        self.speed = meteor.getSpeed()
        self.zPosition = 10.0
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}