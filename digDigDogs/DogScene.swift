//
//  DogScene.swift
//  digDigDogs
//
//  Created by Angelina Olmedo on 1/6/20.
//  Copyright © 2020 Angelina Olmedo. All rights reserved.
//

import Foundation
import SpriteKit
import GameplayKit

class DogScene: SKScene {
    
    
    var inventory: [[Item : Int]]?
    var dogs: [Dog]?
    
    var entities = [GKEntity]()
    var graphs = [String : GKGraph]()
    
    private var muttLabel : SKLabelNode?
    private var pugLabel : SKLabelNode?
    private var bcLabel : SKLabelNode?
    private var asLabel : SKLabelNode?
    private var catLabel : SKLabelNode?
    
    private var muttButton : SKSpriteNode?
    private var pugButton : SKSpriteNode?
    private var bcButton : SKSpriteNode?
    private var asButton : SKSpriteNode?
    private var catButton : SKSpriteNode?
    
    private var lastUpdateTime : TimeInterval = 0
    
    override func sceneDidLoad() {
        self.lastUpdateTime = 0
        
        self.muttLabel = self.childNode(withName: "muttLabel") as? SKLabelNode
        self.pugLabel = self.childNode(withName: "pugLabel") as? SKLabelNode
        self.bcLabel = self.childNode(withName: "bcLabel") as? SKLabelNode
        self.asLabel = self.childNode(withName: "asLabel") as? SKLabelNode
        self.catLabel = self.childNode(withName: "catLabel") as? SKLabelNode
        
        self.muttButton = self.childNode(withName: "mutt") as? SKSpriteNode
        self.pugButton = self.childNode(withName: "pug") as? SKSpriteNode
        self.bcButton = self.childNode(withName: "bc") as? SKSpriteNode
        self.asButton = self.childNode(withName: "as") as? SKSpriteNode
        self.catButton = self.childNode(withName: "cat") as? SKSpriteNode
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
                else if frontTouchedNode! == "mutt" || frontTouchedNode! == "pug" || frontTouchedNode! == "bc" || frontTouchedNode! == "as" || frontTouchedNode! == "cat" {
                    switchActive(frontTouchedNode!)
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
        
        self.lastUpdateTime = currentTime
        
        if dogs != nil {
            updateLabels()
            updateActive()
        }
    }
    
    func updateLabels() {
        muttLabel!.text = "Mutt\nLvl. \(dogs![0].dp ?? 0)\n\"\(dogs![0].dogName ?? "ERROR")\""
        pugLabel!.text = "Pug\nLvl. \(dogs![1].dp ?? 0)\n\"\(dogs![1].dogName ?? "ERROR")\""
        bcLabel!.text = "Border Collie\nLvl. \(dogs![2].dp ?? 0)\n\"\(dogs![2].dogName ?? "ERROR")\""
        asLabel!.text = "Australian Shepherd\nLvl. \(dogs![3].dp ?? 0)\n\"\(dogs![3].dogName ?? "ERROR")\""
        catLabel!.text = "Dog?\nLvl. \(dogs![4].dp ?? 4)\n\"\(dogs![4].dogName ?? "ERROR")\""
    }
    
    func updateActive() {
        // Inactive dogs show up at 50% opacity
        if dogs![0].active {
            muttButton!.alpha = 1
        }
        else {
            muttButton!.alpha = 0.5
        }
        
        if dogs![1].active {
            pugButton!.alpha = 1
        }
        else {
            pugButton!.alpha = 0.5
        }
        
        if dogs![2].active {
            bcButton!.alpha = 1
        }
        else {
            bcButton!.alpha = 0.5
        }
        
        if dogs![3].active {
            asButton!.alpha = 1
        }
        else {
            asButton!.alpha = 0.5
        }
        
        if dogs![4].active {
            catButton!.alpha = 1
        }
        else {
            catButton!.alpha = 0.5
        }
    }
    
    func switchActive (_ name : String) {
        if name == "mutt" {
            dogs![0].active = !dogs![0].active
        }
        else if name == "pug" {
            dogs![1].active = !dogs![1].active
        }
        else if name == "bc" {
            dogs![2].active = !dogs![2].active
        }
        else if name == "as" {
            dogs![3].active = !dogs![3].active
        }
        else if name == "cat" {
            dogs![4].active = !dogs![4].active
        }
    }
}

