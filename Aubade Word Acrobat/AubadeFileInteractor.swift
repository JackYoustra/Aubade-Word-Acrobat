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
    private static var lines: [String] = Array();
    private static var words: [String] = Array();
    
    public static func setupAubade(){
        // file
        let dir: NSString = NSBundle.mainBundle().pathForResource("Aubade", ofType: "txt")!
        let file = try? NSString(contentsOfFile: dir as String, encoding: NSUTF8StringEncoding);
        fileContent = file as! String

        // lines
        let newlineChars = NSCharacterSet.newlineCharacterSet()
        let lines = fileContent.utf16.split { newlineChars.characterIsMember($0) }.flatMap(String.init)
        
        // words
        let builder = NSMutableArray(capacity: lines.count)
        for line: NSString! in lines{
            let wordArr = line.componentsSeparatedByString(" ")
            for word: NSString! in wordArr{
                builder.addObject(word)
            }
        }
        words = builder as NSArray as! [String];
        
//        print("Lines: \(lines) and words: \(words)")
    }
}