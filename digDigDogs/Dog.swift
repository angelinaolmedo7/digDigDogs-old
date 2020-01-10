//
//  Dog.swift
//  digDigDogs
//
//  Created by Angelina Olmedo on 1/8/20.
//  Copyright © 2020 Angelina Olmedo. All rights reserved.
//

import Foundation

class Dog {
    var breed: String!
    var dogName: String!
    var textureName: String!
    var dp: Int!
    var unlocked: Bool!
    var active: Bool!
    var hiddenInCrafting: Bool!
    var accessories: [String] = []
    
    init(breed: String, name: String, texName: String, dp: Int = 0, unlocked: Bool = false, active: Bool = false, hidden: Bool = false) {
        self.breed = breed
        self.dogName = name
        self.textureName = texName
        self.dp = dp
        self.unlocked = unlocked
        self.active = active
        self.hiddenInCrafting = hidden
    }
    
    func generateResource() -> (dp: Int, roll: Int) {
        return (dp: self.dp, roll: (Int.random(in: 1...100)))
    }
}
