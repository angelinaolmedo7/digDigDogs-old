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
            Dog(breed: "Mutt", name: genericDogNames.randomElement()!, dp: 1, unlocked: true, active: true),
            Dog(breed: "Pug", name: genericDogNames.randomElement()!, dp: 1),
            Dog(breed: "Border Collie", name: genericDogNames.randomElement()!, dp: 2),
            Dog(breed: "Australian Shepherd", name: "Tahoe", dp: 3),
            Dog(breed: "Cat?", name: "Lilac", dp: 4)
        ]
        return dogList
    }
}
