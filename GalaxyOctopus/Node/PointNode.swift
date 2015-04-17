//
//  PointNode.swift
//  GalaxyOctopus
//
//  Created by Takuya Tejima on 2015/04/12.
//  Copyright (c) 2015年 Takuya Tejima. All rights reserved.
//

import SpriteKit

class PointNode: SKSpriteNode {
    
    var spped: CGFloat = 0.2
    
    enum Point: Int {
        case fish = 0
        
        static func fromRaw(raw: Int) -> Point {
            switch raw {
            case 0:
                return .fish
            default:
                return .fish
            }
        }
        
        func getImage() -> String {
            switch self.rawValue {
            case 0:
                return "fish.png"
            default:
                return "fish.png"
            }
        }
        
        func getSpeed() -> CGFloat {
            switch self.rawValue {
            case 0:
                return 0.2
            default:
                return 0.2
            }
        }
    }
    
    override init(texture: SKTexture!, color: UIColor!, size: CGSize) {
        let point = Point.fromRaw(0)
        var t = SKTexture(imageNamed: point.getImage())
        super.init(texture: t, color: nil, size: CGSize(width: t.size().width / 4, height: t.size().height / 4))
        self.speed = point.getSpeed()
        self.zPosition = 11.0
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}