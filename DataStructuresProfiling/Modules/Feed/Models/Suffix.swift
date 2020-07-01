//
//  Suffix.swift
//  DataStructuresProfiling
//
//  Created by Роман on 01.07.2020.
//  Copyright © 2020 Exey Panteleev. All rights reserved.
//

import Foundation

struct SuffixSequence: Sequence {
    let text: String
    
    func makeIterator() -> SuffixIterator {
        
        return SuffixIterator(text: self.text)
    }
}

struct SuffixIterator: IteratorProtocol {
    let text: String
    var offset: String.Index
    
    init(text: String) {
        self.text = text
        self.offset = text.endIndex
    }
    
    mutating func next() -> Substring? {
        guard self.offset > self.text.startIndex else { return nil }
        self.offset = self.text.index(before: self.offset)
        
        return self.text[...offset]
    }
}
