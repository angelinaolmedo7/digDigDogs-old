//
//  DogSprite.swift
//  digDigDogs
//
//  Created by Angelina Olmedo on 1/7/20.
//  Copyright © 2020 Angelina Olmedo. All rights reserved.
//

import Foundation
import SpriteKit

class DogSprite: SKSpriteNode {
    
    enum DogBreeds:String, CaseIterable {
        case mutt = "Mutt"
        case pug = "Pug"
        case borderCollie = "Border Collie"
        case australianShepherd = "Australian Shepherd"
        case lilac = "Dog?"
    }
    
    var dogName: String!
    var breed: DogBreeds!
    var dp: Int!
    
    override init(texture: SKTexture?, color: UIColor, size: CGSize) {
        super.init(texture: texture, color: color, size: size)
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func generateResource() -> (dp: Int, roll: Int) {
        print(self.dp)
        return (dp: self.dp ?? 0, roll: (Int.random(in: 1...100)))
    }
}

