//
//  TweetBtn.swift
//  GalaxyOctopus
//
//  Created by Takuya Tejima on 2015/04/18.
//  Copyright (c) 2015年 Takuya Tejima. All rights reserved.
//

import SpriteKit

class TweetBtn: SKSpriteNode {
    
    override init(texture: SKTexture!, color: UIColor!, size: CGSize) {
        var t = SKTexture(imageNamed: "tweet_btn.png")
        super.init(texture: t, color: nil, size: CGSize(width: t.size().width, height: t.size().height))
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
