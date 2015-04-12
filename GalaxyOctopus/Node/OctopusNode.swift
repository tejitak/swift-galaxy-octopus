//
//  OctopusNode.swift
//  GalaxyOctopus
//
//  Created by Takuya Tejima on 2015/04/12.
//  Copyright (c) 2015年 Takuya Tejima. All rights reserved.
//

import SpriteKit

class OctopusNode: SKSpriteNode {
    
    enum NodeSettings: CGFloat {
        case speed = 1000.0
    }
    
    override init(texture: SKTexture!, color: UIColor!, size: CGSize) {
        var texture = SKTexture(imageNamed: "octopus.png")
        super.init(texture: texture, color: color, size: size)
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
