//
//  GameScene.swift
//  Aubade Word Acrobat
//
//  Created by Jack Youstra on 11/20/15.
//  Copyright (c) 2015 HouseMixer. All rights reserved.
//

import SpriteKit

struct PhysicsCategory {
    static let None      : UInt32 = 0
    static let All       : UInt32 = UInt32.max
    static let Window    : UInt32 = 0b1
    static let Word      : UInt32 = 0b10
}

class GameScene: SKScene {
    var start: Bool = false;
    let title = SKLabelNode(fontNamed:"Cornerstone")
    
    func initialization(){
        self.backgroundColor = SKColor.blackColor()
        self.physicsBody = SKPhysicsBody(edgeLoopFromRect: self.frame)
    }
    
    override func didMoveToView(view: SKView) {
        initialization();
        
        /* Setup your scene here */
        title.text = "Aubade";
        title.fontSize = 150;
        title.position = CGPoint(x:CGRectGetMidX(self.frame), y:CGRectGetMidY(self.frame));
        
        self.addChild(title)
    }
    
    override func mouseDown(theEvent: NSEvent) {
        /* Called when a mouse click occurs */
        if(!start){
            start = true
            initialExplosion();
            return;
        }
        
        
        let location = theEvent.locationInNode(self)
        let clickedNode = self.nodeAtPoint(location)
        
        if clickedNode.name == "word" && clickedNode.physicsBody?.pinned == false{
            let clickedWord = clickedNode as! SKLabelNode
            //clickedWord.physicsBody?.applyImpulse(CGVector(dx: 0.0, dy: 20.0))
            let wordText = clickedWord.text!
            let lines = AubadeFileInteractor.getLines()
            
            for var index = 0; index < lines.count; ++index{
                let line = lines[index]
                if line.containsString(wordText){
                    let wordsInLine = line.componentsSeparatedByString(" ")
                    var currentX: CGFloat = 0.0
                    
                    for currentWord in wordsInLine {
                        for node in self.children{
                            if let textNode = node as? SKLabelNode{
                                if textNode.text == currentWord && textNode.physicsBody?.pinned == false{
                                    // calculate
                                    let destination = CGPoint(x: currentX+(textNode.frame.size.width/2), y: CGRectGetMaxY(self.frame) - CGFloat(index)*15) // take into account centering
                                    currentX += textNode.frame.size.width
                                    
                                    print("\(textNode.frame.origin)")
                                    
                                    // move
                                    //textNode.position = destination
                                    let moveToPoint = SKAction.moveTo(destination, duration: 2.0)
                                    let pushUp = SKAction.runBlock({ () -> Void in
                                        textNode.physicsBody?.applyImpulse(CGVector(dx: 0.0, dy: 25.0))
                                    })
                                    textNode.runAction(SKAction.sequence(
                                        [
                                            pushUp,
                                            SKAction.waitForDuration(0.5),
                                            moveToPoint,
                                        ]),
                                        completion: { () -> Void in
                                            // fix node
                                            textNode.position = destination
                                            textNode.zRotation = 0.0
                                            textNode.physicsBody?.pinned = true
                                            textNode.physicsBody?.allowsRotation = false
                                    })
                                    
                                    
                                    break
                                }
                            }
                        }
                        
                    }
                    
                    break
                }
            }
        }
        /*
        let sprite = SKSpriteNode(imageNamed:"Spaceship")
        sprite.position = location;
        sprite.setScale(0.5)
        
        let action = SKAction.rotateByAngle(CGFloat(M_PI), duration:1)
        sprite.runAction(SKAction.repeatActionForever(action))
        
        self.addChild(sprite)
        */
    }
    
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
    }
    
    func initialExplosion(){
        // cleanup
        title.removeFromParent()
        
        let words = AubadeFileInteractor.getWords();
        for word in words{
            let label = createWordLabel(word)
            label.position = CGPoint(x:CGFloat(arc4random() % UInt32(UInt(self.frame.size.width))), y:self.frame.size.height-50);
            self.addChild(label)
        }
    }
    
    func createWordLabel(word: String) -> SKLabelNode{
        let label = SKLabelNode(text: word)
        label.fontName = "Cornerstone"
        label.fontSize = 12
        label.name = "word"
        label.physicsBody = SKPhysicsBody(rectangleOfSize: label.frame.size)
        label.physicsBody?.mass = 0.01
        return label
    }
}










