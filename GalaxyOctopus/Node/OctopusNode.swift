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
    
    override init() {
        let texture = SKTexture(imageNamed: "octopus.png")
        super.init(texture: texture, color: nil, size: CGSize(width: texture.size().width/3, height: texture.size().height/3))
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
