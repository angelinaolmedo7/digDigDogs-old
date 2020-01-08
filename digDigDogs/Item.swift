//
//  Item.swift
//  digDigDogs
//
//  Created by Angelina Olmedo on 1/7/20.
//  Copyright © 2020 Angelina Olmedo. All rights reserved.
//

import Foundation
import SpriteKit

struct Item : Hashable{
    
    enum Rarity: String{
        case currency = "currency"
        case trash = "trash"
        case vcommon = "very common"
        case common = "common"
        case uncommon = "uncommon"
        case unusual = "unusual"
        case rare = "rare"
        case vrare = "very rare"
        case unique = "unique"
    }
    
    var name: String
    var rarity: Rarity
    var textureName: String?
    
    init(name: String, rarity: Rarity, tName: String = "default") {
        self.name = name
        self.rarity = rarity
        self.textureName = tName
    }
}
