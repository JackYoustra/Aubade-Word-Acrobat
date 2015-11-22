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
    var positionTable = Dictionary<SKLabelNode, CGPoint>(minimumCapacity: AubadeFileInteractor.getWords().count) // holds labels and where they should go when clicked on
    var lineNodeTable = Dictionary<String, Array<SKLabelNode>>()
    
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
                    let nodes = lineNodeTable[line]!
                    for textNode in nodes{
                        // calculate
                        let destination = positionTable[textNode]!
                        
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
                                textNode.physicsBody?.dynamic = false
                        })
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
        
        let lines = AubadeFileInteractor.getLines();
        let importance = AubadeFileInteractor.getWordImportance()
        
        for var index = 0; index < lines.count; ++index{
            let line = lines[index]
            let wordsInLine = line.componentsSeparatedByString(" ")
            var lineNodes = Array<SKLabelNode>()
            var currentX: CGFloat = 0.0
            for word in wordsInLine{
                let label = createWordLabel(word)
                label.fontSize = label.fontSize + (CGFloat(importance[word.lowercaseString]!) * 2.0)
                
                let poemPlacement = CGPoint(x: currentX+(label.frame.size.width/2), y: CGRectGetMaxY(self.frame) - CGFloat(index)*14 - 15) // take into account centering & top row
                currentX += label.frame.size.width
                positionTable[label] = poemPlacement
                lineNodes.append(label)
                
                label.position = CGPoint(x:CGFloat(arc4random() % UInt32(UInt(self.frame.size.width))), y:self.frame.size.height-50);
                self.addChild(label)
            }
            lineNodeTable[line] = lineNodes
        }
    }
    
    func createWordLabel(word: String) -> SKLabelNode{
        let label = SKLabelNode(text: word)
        label.fontName = "Cornerstone"
        label.fontSize = 8
        label.name = "word"
        label.physicsBody = SKPhysicsBody(rectangleOfSize: label.frame.size)
        label.physicsBody?.mass = 0.01
        return label
    }
}










