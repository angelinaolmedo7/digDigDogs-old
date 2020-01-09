//
//  GameScene.swift
//  digDigDogs
//
//  Created by Angelina Olmedo on 1/6/20.
//  Copyright © 2020 Angelina Olmedo. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {
    
    var entities = [GKEntity]()
    var graphs = [String : GKGraph]()
    
    private var lastUpdateTime : TimeInterval = 0
    private var invButton : SKSpriteNode?
    private var dogButton : SKSpriteNode?
    
    
    var inventory: [[Item : Int]]?
    
    //up to three dogs in a scene
    var dogs: [Dog]?
    var dogOne: DogSprite? 
    var dogTwo: DogSprite?
    var dogThree: DogSprite?
    
    var dogOneLabel : SKLabelNode?
    var dogTwoLabel : SKLabelNode?
    var dogThreeLabel : SKLabelNode?
    
    override func sceneDidLoad() {

        self.lastUpdateTime = 0
        
        // Get label node from scene and store it for use later
        self.dogOneLabel = self.childNode(withName: "dog1Label") as? SKLabelNode
        self.invButton = self.childNode(withName: "invButton") as? SKSpriteNode
        self.dogButton = self.childNode(withName: "dogButton") as? SKSpriteNode
        
        self.dogOne = self.childNode(withName: "dog") as? DogSprite
        
//        if let label = self.label {
//            label.alpha = 0.0
//            label.run(SKAction.fadeIn(withDuration: 2.0))
//        }
        
        if inventory == nil {
            establishItems()
        }
        if dogs == nil {
            dogs = Helper.getDogList()
        }
    }
    
    
    func touchDown(atPoint pos : CGPoint) {
    }
    
    func touchMoved(toPoint pos : CGPoint) {
    }
    
    func touchUp(atPoint pos : CGPoint) {
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            let location = touch.location(in: self)
            let dogNode = atPoint(location) as? DogSprite
            let frontTouchedNode = atPoint(location).name
            //print(frontTouchedNode)
            
            //if there is a node where the user tapped
            if frontTouchedNode != nil{
                //print(frontTouchedNode!)
                if frontTouchedNode! == "invButton" {
                    toInv()
                }
                else if frontTouchedNode! == "dogButton" {
                    toDogs()
                }
                else if dogNode != nil {
                    handleItemRoll(dogNode!.generateResource())
                }
            }
        }
    }
    
    func toInv() {
        if let scene = GKScene(fileNamed: "InventoryScene") {
            
            // Get the SKScene from the loaded GKScene
            if let sceneNode = scene.rootNode as! InventoryScene? {
                
                // Copy gameplay related content over to the scene
                sceneNode.entities = scene.entities
                sceneNode.graphs = scene.graphs
                
                // Pass inventory information
                sceneNode.inventory = self.inventory
                
                // Set the scale mode to scale to fit the window
                sceneNode.scaleMode = .aspectFill
                
                // Present the scene
                if let view = self.view as! SKView? {
                    view.presentScene(sceneNode)
                    
                    view.ignoresSiblingOrder = true
                    
                    view.showsFPS = true
                    view.showsNodeCount = true
                }
            }
        }
    }
    
    func toDogs() {
        if let scene = GKScene(fileNamed: "DogScene") {
            
            // Get the SKScene from the loaded GKScene
            if let sceneNode = scene.rootNode as! DogScene? {
                
                // Copy gameplay related content over to the scene
                sceneNode.entities = scene.entities
                sceneNode.graphs = scene.graphs
                
                // Set the scale mode to scale to fit the window
                sceneNode.scaleMode = .aspectFill
                
                // Present the scene
                if let view = self.view as! SKView? {
                    view.presentScene(sceneNode)
                    
                    view.ignoresSiblingOrder = true
                    
                    view.showsFPS = true
                    view.showsNodeCount = true
                }
            }
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchMoved(toPoint: t.location(in: self)) }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchUp(atPoint: t.location(in: self)) }
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchUp(atPoint: t.location(in: self)) }
    }
    
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
        
        // Initialize _lastUpdateTime if it has not already been
        if (self.lastUpdateTime == 0) {
            self.lastUpdateTime = currentTime
        }
        
        // Calculate time since last update
        let dt = currentTime - self.lastUpdateTime
        
        // Update entities
        for entity in self.entities {
            entity.update(deltaTime: dt)
        }
        
        self.lastUpdateTime = currentTime
    }
    
    func establishItems() {
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
        
        var commonItemDict : [Item : Int] = [:]
        for name in Helper.commonItemNames {
            let newItem = Item(name: name, rarity: Item.Rarity.common)
            commonItemDict[newItem] = 0
        }
        
        var rareItemDict : [Item : Int] = [:]
        for name in Helper.rareItemNames {
            let newItem = Item(name: name, rarity: Item.Rarity.rare)
            rareItemDict[newItem] = 0
        }
        
        self.inventory = [currencyDict, trashItemDict, commonItemDict, rareItemDict]
    }
    
    func handleItemRoll (_ itemRoll: (dp: Int, roll: Int)) {
        // Make sure inv exists
        guard self.inventory != nil else {
            return
        }
        // Determine item
        var newItem: (itm:Item, quantity:Int)
        if itemRoll.roll <= 30 {
            newItem = (Item(name: "coins", rarity: Item.Rarity.currency), calcCoins(exponent(base: 2, exp: itemRoll.dp)))
        }
        else {
            newItem = (Item(name: Helper.trashItemNames.randomElement()!, rarity: Item.Rarity.trash), 1)
        }
        
        // Add quantity of item to proper dict value
        for catagory in inventory! {
            if catagory[newItem.itm] != nil {
                inventory![(inventory?.firstIndex(of: catagory))!][newItem.itm]! += newItem.quantity
            }
        }
        
    }
    
    func calcCoins (_ multiplyer: Int) -> Int {
        return Int.random(in: 1...20)*multiplyer
    }
    
    func exponent(base: Int, exp: Int) -> Int {
        if exp == 0 {
            return 1
        }
        var result: Int = 1
        for _ in 1 ... exp {
            result *= base
        }
        return result
    }
}
