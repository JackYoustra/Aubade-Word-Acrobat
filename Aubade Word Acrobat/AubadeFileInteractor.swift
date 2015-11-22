//
//  AubadeFileInteractor.swift
//  Aubade Word Acrobat
//
//  Created by Jack Youstra on 11/20/15.
//  Copyright © 2015 HouseMixer. All rights reserved.
//

import Foundation

public class AubadeFileInteractor{
    private static var fileContent: String = "";
    private static var importanceContent = "";
    private static var poemLines: [String] = Array();
    private static var words: [String] = Array();
    private static var wordImportance: Dictionary<String, Int> = Dictionary()
    
    public static func setupAubade(){
        // file
        let dir: NSString = NSBundle.mainBundle().pathForResource("Aubade", ofType: "txt")!
        let file = try? NSString(contentsOfFile: dir as String, encoding: NSUTF8StringEncoding);
        fileContent = file as! String

        importanceContent = try! NSString(contentsOfFile: NSBundle.mainBundle().pathForResource("AubadeWordImportance", ofType: "txt")! as String, encoding: NSUTF8StringEncoding) as String;
        
        // lines
        let newlineChars = NSCharacterSet.newlineCharacterSet()
        poemLines = fileContent.utf16.split { newlineChars.characterIsMember($0) }.flatMap(String.init)
        
        // words
        let builder = NSMutableArray(capacity: poemLines.count)
        for line: String in poemLines{
            let wordArr = line.componentsSeparatedByString(" ")
            for word: NSString! in wordArr{
                builder.addObject(word)
            }
        }
        words = builder as NSArray as! [String];
        
        // word importance
        let importanceLines = importanceContent.utf16.split { newlineChars.characterIsMember($0) }.flatMap(String.init)
        for line: String in importanceLines{
            let dichotomy = line.componentsSeparatedByString(" ")
            wordImportance[dichotomy[0].lowercaseString] = Int(dichotomy[1])!
        }
                
//        print("Lines: \(lines) and words: \(words)")
    }
    
    public static func getLines() -> [String]{
        return poemLines;
    }
    
    public static func getWords() -> [String]{
        return words;
    }
    
    public static func getWordImportance() -> Dictionary<String, Int>{
        return wordImportance;
    }
}