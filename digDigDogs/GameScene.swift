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
        dogOneLabel!.isHidden = true
        self.dogTwoLabel = self.childNode(withName: "dog2Label") as? SKLabelNode
        dogTwoLabel!.isHidden = true
        self.dogThreeLabel = self.childNode(withName: "dog3Label") as? SKLabelNode
        dogThreeLabel!.isHidden = true
        
        self.invButton = self.childNode(withName: "invButton") as? SKSpriteNode
        self.dogButton = self.childNode(withName: "dogButton") as? SKSpriteNode
        
        self.dogOne = self.childNode(withName: "dog1") as? DogSprite
        self.dogTwo = self.childNode(withName: "dog2") as? DogSprite
        self.dogThree = self.childNode(withName: "dog3") as? DogSprite
        
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

            // Fade animation
            let fadeOut = SKAction.fadeAlpha(to: 0, duration: 0.5)
            let fadeIn = SKAction.fadeAlpha(to: 1, duration: 0.5)
            let fadeInOut = SKAction.sequence([fadeIn, fadeOut])
            
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
                    let roll = handleItemRoll(dogNode!.generateResource())
                    if frontTouchedNode! == "dog1" {
                        dogOneLabel!.text = roll
                        dogOneLabel!.alpha = 0
                        dogOneLabel!.isHidden = false
                        dogOneLabel!.run(fadeInOut)
//                        dogOneLabel!.isHidden = true
                    }
                    if frontTouchedNode! == "dog2" {
                        dogTwoLabel!.text = roll
                        dogTwoLabel!.alpha = 0
                        dogTwoLabel!.isHidden = false
                        dogTwoLabel!.run(fadeInOut)
                    }
                    if frontTouchedNode! == "dog3" {
                        dogThreeLabel!.text = roll
                        dogThreeLabel!.alpha = 0
                        dogThreeLabel!.isHidden = false
                        dogThreeLabel!.run(fadeInOut)
                    }
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
                sceneNode.dogs = self.dogs
                
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
                
                // Pass inventory and dog information
                sceneNode.inventory = self.inventory
                sceneNode.dogs = self.dogs
                
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
        
        if dogs != nil {
            setActiveDogs()
        }
    }
    
    func establishItems() {
        self.inventory = Helper.generateEmptyItems()
    }
    
    func handleItemRoll (_ itemRoll: (dp: Int, roll: Int)) -> String {
        // Make sure inv exists
        guard self.inventory != nil else {
            return "ERROR"
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
        return "+\(newItem.quantity) \(newItem.itm.name)"
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
    
    func setActiveDogs(){
        let active : [Dog]? = Helper.activeDogs(dogs!)
        if active!.count >= 1 {
            dogOne!.texture = SKTexture(imageNamed: active![0].textureName)
            if active!.count == 1 {
                dogTwo!.isHidden = true
                dogThree!.isHidden = true
            }
        }
        if active!.count >= 2 {
            dogTwo?.texture = SKTexture(imageNamed: active![1].textureName)
            dogTwo!.isHidden = false
            if active!.count == 2 {
                dogThree!.isHidden = true
            }
        }
        if active!.count >= 3 {
            dogThree?.texture = SKTexture(imageNamed: active![2].textureName)
            dogThree!.isHidden = false
        }
    }
}
