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
    static let commonItemNames : [String] = ["twine", "screw", "battery", "flower", "leaf"]
    static let rareItemNames : [String] = ["ribbon", "teddy bear"]
    
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
}
