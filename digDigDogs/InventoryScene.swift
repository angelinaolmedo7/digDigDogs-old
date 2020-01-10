//
//  InventoryScene.swift
//  digDigDogs
//
//  Created by Angelina Olmedo on 1/6/20.
//  Copyright © 2020 Angelina Olmedo. All rights reserved.
//

import SpriteKit
import GameplayKit

class InventoryScene: SKScene {
    
    var inventory: [[Item : Int]]?
    var dogs: [Dog]?
    
    var entities = [GKEntity]()
    var graphs = [String : GKGraph]()
    
    private var lastUpdateTime : TimeInterval = 0
    // Trash items
    private var capCount : SKLabelNode?
    private var wrapperCount : SKLabelNode?
    private var canCount : SKLabelNode?
    
    // Very common items
    private var twineCount : SKLabelNode?
    private var screwCount : SKLabelNode?
    private var boneCount : SKLabelNode?
    
    // Common items
    private var blackFurCount : SKLabelNode?
    private var grayFurCount : SKLabelNode?
    private var whiteFurCount : SKLabelNode?
    private var yellowFurCount : SKLabelNode?
    private var brownFurCount : SKLabelNode?
    
    // Uncommon items
    private var dogTagCount : SKLabelNode?
    private var collarCount : SKLabelNode?
    private var leashCount : SKLabelNode?
    
    // Unusual items
    private var blanketCount : SKLabelNode?
    private var dogTreatCount : SKLabelNode?
    private var bowCount : SKLabelNode?
    
    // Rare items
    private var ribbonCount : SKLabelNode?
    private var teddyBearCount : SKLabelNode?
    
    // Very rare items
    private var fossilPlantCount : SKLabelNode?
    private var fossilDinoCount : SKLabelNode?
    private var fossilFishCount : SKLabelNode?
    
    
    override func sceneDidLoad() {
        self.lastUpdateTime = 0
        
        self.capCount = self.childNode(withName: "capCount") as? SKLabelNode
        self.wrapperCount = self.childNode(withName: "wrapperCount") as? SKLabelNode
        self.canCount = self.childNode(withName: "canCount") as? SKLabelNode
        
        self.twineCount = self.childNode(withName: "twineCount") as? SKLabelNode
        self.screwCount = self.childNode(withName: "screwCount") as? SKLabelNode
        self.boneCount = self.childNode(withName: "boneCount") as? SKLabelNode
        
        self.blackFurCount = self.childNode(withName: "blackFurCount") as? SKLabelNode
        self.grayFurCount = self.childNode(withName: "grayFurCount") as? SKLabelNode
        self.whiteFurCount = self.childNode(withName: "whiteFurCount") as? SKLabelNode
        self.yellowFurCount = self.childNode(withName: "yellowFurCount") as? SKLabelNode
        self.brownFurCount = self.childNode(withName: "brownFurCount") as? SKLabelNode
        
        self.dogTagCount = self.childNode(withName: "dogTagCount") as? SKLabelNode
        self.collarCount = self.childNode(withName: "collarCount") as? SKLabelNode
        self.leashCount = self.childNode(withName: "leashCount") as? SKLabelNode
        
        self.blanketCount = self.childNode(withName: "blanketCount") as? SKLabelNode
        self.dogTreatCount = self.childNode(withName: "dogTreatCount") as? SKLabelNode
        self.bowCount = self.childNode(withName: "bowCount") as? SKLabelNode
        
        self.ribbonCount = self.childNode(withName: "ribbonCount") as? SKLabelNode
        self.teddyBearCount = self.childNode(withName: "teddyBearCount") as? SKLabelNode
        
        self.fossilPlantCount = self.childNode(withName: "fossilPlantCount") as? SKLabelNode
        self.fossilDinoCount = self.childNode(withName: "fossilDinoCount") as? SKLabelNode
        self.fossilFishCount = self.childNode(withName: "fossilFishCount") as? SKLabelNode
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
            let frontTouchedNode = atPoint(location).name
            //print(frontTouchedNode)
            
            //if there is a node where the user tapped
            if frontTouchedNode != nil{
                //print(frontTouchedNode!)
                if frontTouchedNode! == "backButton" {
                    toYard()
                }
            }
        }
    }
    
    func toYard() {
        if let scene = GKScene(fileNamed: "GameScene") {
            
            // Get the SKScene from the loaded GKScene
            if let sceneNode = scene.rootNode as! GameScene? {
                
                // Copy gameplay related content over to the scene
                sceneNode.entities = scene.entities
                sceneNode.graphs = scene.graphs
                
                // Pass back inventory info
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
        
        // Update inventory display
        if inventory != nil {
            setItemsLabel()
        }
        
        self.lastUpdateTime = currentTime
    }
    
    func setItemsLabel() {
        var labelText : String = "Coins: "
        for item in inventory![0] {
            labelText += "\(String(item.value))\n"
        }
        
        print(String(describing: inventory![1]))
        
        capCount?.text = String(describing: inventory![1][Item(name: "bottle cap", rarity: Item.Rarity.trash)]!)
        wrapperCount?.text = String(describing: inventory![1][Item(name: "wrapper", rarity: Item.Rarity.trash)]!)
        canCount?.text = String(describing: inventory![1][Item(name: "can", rarity: Item.Rarity.trash)]!)
        
        twineCount?.text = String(describing: inventory![2][Item(name: "twine", rarity: Item.Rarity.vcommon)]!)
        screwCount?.text = String(describing: inventory![2][Item(name: "screw", rarity: Item.Rarity.vcommon)]!)
        boneCount?.text = String(describing: inventory![2][Item(name: "bone", rarity: Item.Rarity.vcommon)]!)
        
        blackFurCount?.text = String(describing: inventory![3][Item(name: "black fur", rarity: Item.Rarity.common)]!)
        grayFurCount?.text = String(describing: inventory![3][Item(name: "gray fur", rarity: Item.Rarity.common)]!)
        whiteFurCount?.text = String(describing: inventory![3][Item(name: "white fur", rarity: Item.Rarity.common)]!)
        yellowFurCount?.text = String(describing: inventory![3][Item(name: "yellow fur", rarity: Item.Rarity.common)]!)
        brownFurCount?.text = String(describing: inventory![3][Item(name: "brown fur", rarity: Item.Rarity.common)]!)
        
        dogTagCount?.text = String(describing: inventory![4][Item(name: "dog tag", rarity: Item.Rarity.uncommon)]!)
        collarCount?.text = String(describing: inventory![4][Item(name: "collar", rarity: Item.Rarity.uncommon)]!)
        leashCount?.text = String(describing: inventory![4][Item(name: "leash", rarity: Item.Rarity.uncommon)]!)
        
        blanketCount?.text = String(describing: inventory![5][Item(name: "blanket", rarity: Item.Rarity.unusual)]!)
        dogTreatCount?.text = String(describing: inventory![5][Item(name: "dog treat", rarity: Item.Rarity.unusual)]!)
        bowCount?.text = String(describing: inventory![5][Item(name: "bow", rarity: Item.Rarity.unusual)]!)
        
        ribbonCount?.text = String(describing: inventory![6][Item(name: "ribbon", rarity: Item.Rarity.rare)]!)
        teddyBearCount?.text = String(describing: inventory![6][Item(name: "teddy bear", rarity: Item.Rarity.rare)]!)
        
        fossilPlantCount?.text = String(describing: inventory![7][Item(name: "fossil plant", rarity: Item.Rarity.vrare)]!)
        fossilDinoCount?.text = String(describing: inventory![7][Item(name: "fossil dino", rarity: Item.Rarity.vrare)]!)
        fossilFishCount?.text = String(describing: inventory![7][Item(name: "fossil fish", rarity: Item.Rarity.vrare)]!)
    }
}
