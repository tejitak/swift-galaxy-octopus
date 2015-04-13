//
//  MeteorNode.swift
//  GalaxyOctopus
//
//  Created by Takuya Tejima on 2015/04/12.
//  Copyright (c) 2015年 Takuya Tejima. All rights reserved.
//

import SpriteKit

class MeteorNode: SKSpriteNode {
    
    enum MeteorName {
        case Normal
        
        func toString()->String{
            switch self {
            case .Normal:
                return "meteor_normal.png"
            }
        }
    }
    
    enum NodeSettings: CGFloat {
        case speed = 0.2
    }
    
    override init() {
        let texture = SKTexture(imageNamed: MeteorName.Normal.toString())
        super.init(texture: texture, color: nil, size: CGSize(width: texture.size().width / 4, height: texture.size().height / 4))
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}