//
//  LojbanDictionaryTests.swift
//  LojbanDictionaryTests
//
//  Created by Masato Hagiwara on 3/6/17.
//  Copyright © 2017 Masato Hagiwara. All rights reserved.
//

import XCTest
@testable import LojbanDictionary

class LojbanDictionaryTests: XCTestCase {
    
    func testDictionaryModel() {
        
        // Test DictionaryEntry
        var entry = DictionaryEntry(json: ["foo": "bar"])
        XCTAssertNil(entry)
        
        entry = DictionaryEntry(json: ["word": 1])
        XCTAssertNil(entry)
        
        entry = DictionaryEntry(json:
            ["word": "a", "english": "b", "selmaho": "A"])
        XCTAssertEqual("a", entry!.word)
        XCTAssertEqual("b", entry!.english)
        XCTAssertEqual("A", entry!.selmaho)
        XCTAssertEqual("DictionaryEntry(word: \"a\", english: \"b\")", entry!.description)

        entry = DictionaryEntry(json:
            ["word": "a", "english": "b", "selmaho": 1])
        XCTAssertEqual("a", entry!.word)
        XCTAssertEqual("b", entry!.english)
        XCTAssertNil(entry!.selmaho)
        
        // Test DictionaryModel
        var dict = DictionaryModel()
        
        XCTAssertEqual(0, dict.count())
        
        dict = DictionaryModel(json: [
            "a": ["word": "a", "english": "A"],
            "b": ["word": "b", "english": "B"],
            "x": ["foo", "bar"],     // missing "word"
            "y": ["word": "y"]       // missing "english"
            ])
        XCTAssertEqual(2, dict.count())
        
        var entryScores = dict.search(query: "a")
        XCTAssertEqual(1, entryScores.count)
        XCTAssertEqual("a", entryScores.keys.first?.word)
        
        entryScores = dict.search(query: "B")
        XCTAssertEqual(1, entryScores.count)
        XCTAssertEqual("b", entryScores.keys.first?.word)
    }
}
