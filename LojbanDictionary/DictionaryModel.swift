//
//  DictionaryModel.swift
//  LojbanDictionary
//
//  Created by Masato Hagiwara on 3/7/17.
//  Copyright © 2017 Masato Hagiwara. All rights reserved.
//

import UIKit

class DictionaryEntry: NSObject {
    
    let word: String
    let english: String

    let selmaho: String?
    let definition: String?
    let notes: String?
    
    init?(json: [String: Any]) {
        
        // Initialize DictionaryEntry from a JSON object.
        
        // "word" is a mandatory key - return nil if not found (or other type)
        guard let word = json["word"] as? String else {
            return nil
        }
        
        // "english" is also a mandatory key
        guard let english = json["english"] as? String else {
            return nil
        }
        
        self.word = word
        self.english = english
        self.selmaho = json["selmaho"] as? String
        self.definition = json["definition"] as? String
        self.notes = json["notes"] as? String
    }
    
    override public var description: String {
        return "DictionaryEntry(word: \"\(self.word)\", english: \"\(self.english)\")"
    }
}

class DictionaryModel: NSObject {

    var entries = [DictionaryEntry]()
    
    init(json: [String: Any]) {

        // Initialize DictionaryModel from a JSON object.
        for entryJson in json.values {
            guard let entryJsonAsDict = entryJson as? [String: Any] else {
                continue
            }

            guard let entry = DictionaryEntry(json: entryJsonAsDict) else {
                continue
            }
            
            self.entries.append(entry)
        }
    }
    
    override init() {
        // Initialize an empty DictionaryModel
        super.init()
    }
    
    func count() -> Int {
        // Returns the number of entries currently in the dict.
        return self.entries.count
    }
    
    func search(query: String) -> [DictionaryEntry:Int] {
        // Search entries by query, and returns matched entries and their scores.
        
        var entryScores = [DictionaryEntry:Int]()
        
        for entry in self.entries {
            var score = 0
            if let wordRange = entry.word.range(of: query) {
                score += 10

                // extra points if starts with the word
                if (entry.word.startIndex == wordRange.lowerBound) {
                    score += 10
                }
            }
            
            let englishRange = entry.english.range(of: query)
            if (englishRange != nil) {
                score += 10
            }
            
            if (score > 0) {
                entryScores[entry] = score
            }
        }
        return entryScores
    }
    
    func topN(query: String, n: Int) -> [DictionaryEntry] {
        // Search entries by query, and returns a ranked top N list of entries.
        
        let entryScores = self.search(query: query)
        if (entryScores.count > 0) {
            let sortedEntries: [DictionaryEntry] = Array(entryScores.keys.sorted(by: {entryScores[$0]! > entryScores[$1]!})[0..<min(n, entryScores.count)])
            return sortedEntries
        } else {
            return [DictionaryEntry]()
        }
    }
}
