//
//  GameScene.swift
//  Kamakazee
//
//  Created by uppersky04 on 4/15/15.
//  Copyright (c) 2015 uppersky. All rights reserved.
//

/*
original

import SpriteKit

class GameScene: SKScene {
    override func didMoveToView(view: SKView) {
        /* Setup your scene here */
        let myLabel = SKLabelNode(fontNamed:"Chalkduster")
        myLabel.text = "Hello, World!";
        myLabel.fontSize = 65;
        myLabel.position = CGPoint(x:CGRectGetMidX(self.frame), y:CGRectGetMidY(self.frame));
        
        self.addChild(myLabel)
    }
    
    override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
        /* Called when a touch begins */
        
        for touch: AnyObject in touches {
            let location = touch.locationInNode(self)
            
            let sprite = SKSpriteNode(imageNamed:"Spaceship")
            
            sprite.xScale = 0.5
            sprite.yScale = 0.5
            sprite.position = location
            
            let action = SKAction.rotateByAngle(CGFloat(M_PI), duration:1)
            
            sprite.runAction(SKAction.repeatActionForever(action))
            
            self.addChild(sprite)
        }
    }
   
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
    }
}

*/



import SpriteKit

class GameScene: SKScene {
    
    var score = 0
    var health = 5
    var gameOver : Bool?
    let maxNumberOfShips = 10
    var currentNumberOfShips : Int?
    var timeBetweenShips : Double?
    var moverSpeed = 5.0
    let moveFactor = 1.05
    var now : NSDate?
    var nextTime : NSDate?
    var gameOverLabel : SKLabelNode?
    var healthLabel : SKLabelNode?
    
    /*
    Entry point into our scene
    */
    override func didMoveToView(view: SKView) {
        initializeValues()
    }
    
    /*
    Sets the initial values for our variables.
    */
    func initializeValues(){
        self.removeAllChildren()
        
        score = 0
        gameOver = false
        currentNumberOfShips = 0
        timeBetweenShips = 1.0
        moverSpeed = 5.0
        health = 5
        nextTime = NSDate()
        now = NSDate()
        
        healthLabel = SKLabelNode(fontNamed:"System")
        healthLabel?.text = "Health: \(health)"
        healthLabel?.fontSize = 30
        healthLabel?.fontColor = SKColor.blackColor()
        healthLabel?.position = CGPoint(x:CGRectGetMinX(self.frame) + 80, y:(CGRectGetMinY(self.frame) + 100));
        
        self.addChild(healthLabel!)
    }
    
    /*
    Called before each frame is rendered
    */
    override func update(currentTime: CFTimeInterval) {
        
        healthLabel?.text="Health: \(health)"
        if(health <= 3){
            healthLabel?.fontColor = SKColor.redColor()
        }
        
        now = NSDate()
        if (currentNumberOfShips < maxNumberOfShips &&
            now?.timeIntervalSince1970 > nextTime?.timeIntervalSince1970 &&
            health > 0){
                
                nextTime = now?.dateByAddingTimeInterval(NSTimeInterval(timeBetweenShips!))
                var newX = Int(arc4random()%1024)
                var newY = Int(self.frame.height+10)
                var p = CGPoint(x:newX,y:newY)
                var destination =  CGPoint(x: newX, y: 0)
                
                println(destination)
                
                createShip(p, destination: destination)
                
                moverSpeed = moverSpeed/moveFactor
                timeBetweenShips = timeBetweenShips!/moveFactor
        }
        checkIfShipsReachTheBottom()
        checkIfGameIsOver()
    }
    
    /*
    Creates a ship
    Rotates it 90º
    Adds a mover to it go downwards
    Adds the ship to the scene
    */
    func createShip(p:CGPoint, destination:CGPoint) {
        let sprite = SKSpriteNode(imageNamed:"Spaceship")
        sprite.name = "Destroyable"
        sprite.xScale = 0.5
        sprite.yScale = 0.5
        sprite.position = p
        
        let duration = NSTimeInterval(moverSpeed)
        let action = SKAction.moveTo(destination, duration: duration)
        sprite.runAction(SKAction.repeatActionForever(action))
        
        let rotationAction = SKAction.rotateToAngle(CGFloat(3.142), duration: 0)
        sprite.runAction(SKAction.repeatAction(rotationAction, count: 0))
        
        currentNumberOfShips?+=1
        self.addChild(sprite)
    }
    
    /*
    Called when a touch begins
    */
    override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
        
        
        for touch: AnyObject in touches {
            let location = (touch as UITouch).locationInNode(self)
            if let theName = self.nodeAtPoint(location).name {
                if theName == "Destroyable" {
                    self.removeChildrenInArray([self.nodeAtPoint(location)])
                    currentNumberOfShips?-=1
                    score+=1
                }
            }
            if (gameOver?==true){
                initializeValues()
            }
        }
    }
    
    /*
    Check if the game is over by looking at our health
    Shows game over screen if needed
    */
    func checkIfGameIsOver(){
        if (health <= 0 && gameOver == false){
            self.removeAllChildren()
            showGameOverScreen()
            gameOver = true
        }
    }
    
    /*
    Checks if an enemy ship reaches the bottom of our screen
    */
    func checkIfShipsReachTheBottom(){
        for child in self.children {
            if(child.position.y == 0){
                self.removeChildrenInArray([child])
                currentNumberOfShips?-=1
                health -= 1
            }
        }
    }
    
    /*
    Displays the actual game over screen
    */
    func showGameOverScreen(){
        gameOverLabel = SKLabelNode(fontNamed:"System")
        gameOverLabel?.text = "Game Over! Score: \(score)"
        gameOverLabel?.fontColor = SKColor.redColor()
        gameOverLabel?.fontSize = 65;
        gameOverLabel?.position = CGPoint(x:CGRectGetMidX(self.frame), y:CGRectGetMidY(self.frame));
        self.addChild(gameOverLabel!)
    }
}