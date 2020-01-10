//
//  Helper.swift
//  digDigDogs
//
//  Created by Angelina Olmedo on 1/8/20.
//  Copyright © 2020 Angelina Olmedo. All rights reserved.
//

import Foundation

class Helper {

    static let currencyNames : [String] = ["coins"]
    static let trashItemNames : [String] = ["bottle cap", "can", "wrapper"]
    static let vCommonItemNames : [String] = ["twine", "screw", "battery", "flower", "leaf"]
    static let commonItemNames : [String] = ["brown fur", "white fur", "black fur", "yellow fur", "gray fur", "bone"]
    static let uncommonItemNames : [String] = ["bow", "collar", "leash", "dog tag"]
    static let unusualItemNames : [String] = ["blanket", "dog treat", "dog toy"]
    static let rareItemNames : [String] = ["ribbon", "teddy bear"]
    static let vRareItemNames : [String] = ["plant fossil", "dino fossil", "fish fossil"]
    
    static let dogBreeds : [String] = ["Mutt", "Pug", "Border Collie", "Australian Shepherd", "Dog?"]
    static let genericDogNames : [String] = [
        "Max",
        "Fluffy",
        "Rufus",
        "Lilac",
        "Tank",
        "Hank"
    ]
    
    // Return a default list of dogs
    static func getDogList() -> [Dog] {
        let dogList: [Dog] = [
            Dog(breed: "Mutt", name: genericDogNames.randomElement()!, texName: "mutt", dp: 1, unlocked: true, active: true),
            Dog(breed: "Pug", name: genericDogNames.randomElement()!, texName: "pug", dp: 1),
            Dog(breed: "Border Collie", name: genericDogNames.randomElement()!, texName: "borderCollie", dp: 2),
            Dog(breed: "Australian Shepherd", name: "Tahoe", texName: "tahoe", dp: 3),
            Dog(breed: "Cat?", name: "Lilac", texName: "lilac", dp: 4)
        ]
        return dogList
    }
    
    static func activeDogs(_ dogs: [Dog]) -> [Dog] {
        var rtnDogs : [Dog] = []
        for dog in dogs {
            if dog.active {
                rtnDogs.append(dog)
            }
        }
        return rtnDogs
    }
    
    static func generateEmptyItems() -> [[Item : Int]] {
        var currencyDict : [Item : Int] = [:]
        for name in Helper.currencyNames {
            let newItem = Item(name: name, rarity: Item.Rarity.currency)
            currencyDict[newItem] = 0
        }
        
        var trashItemDict : [Item : Int] = [:]
        for name in Helper.trashItemNames {
            let newItem = Item(name: name, rarity: Item.Rarity.trash)
            trashItemDict[newItem] = 0
        }
        
        var vCommonItemDict : [Item : Int] = [:]
        for name in Helper.vCommonItemNames {
            let newItem = Item(name: name, rarity: Item.Rarity.vcommon)
            vCommonItemDict[newItem] = 0
        }
        
        var commonItemDict : [Item : Int] = [:]
        for name in Helper.commonItemNames {
            let newItem = Item(name: name, rarity: Item.Rarity.common)
            commonItemDict[newItem] = 0
        }
        
        var uncommonItemDict : [Item : Int] = [:]
        for name in Helper.uncommonItemNames {
            let newItem = Item(name: name, rarity: Item.Rarity.uncommon)
            uncommonItemDict[newItem] = 0
        }
        
        var unusualItemDict : [Item : Int] = [:]
        for name in Helper.unusualItemNames {
            let newItem = Item(name: name, rarity: Item.Rarity.unusual)
            unusualItemDict[newItem] = 0
        }
        
        var rareItemDict : [Item : Int] = [:]
        for name in Helper.rareItemNames {
            let newItem = Item(name: name, rarity: Item.Rarity.rare)
            rareItemDict[newItem] = 0
        }
        
        var vRareItemDict : [Item : Int] = [:]
        for name in Helper.vRareItemNames {
            let newItem = Item(name: name, rarity: Item.Rarity.vrare)
            vRareItemDict[newItem] = 0
        }
        
        return [currencyDict, vCommonItemDict, commonItemDict, uncommonItemDict, unusualItemDict, rareItemDict, vRareItemDict]
    }
}
