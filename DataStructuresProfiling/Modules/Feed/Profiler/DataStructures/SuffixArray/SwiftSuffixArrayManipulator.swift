//
//  SwiftSuffixArrayManipulator.swift
//  DataStructuresProfiling
//
//  Created by Роман on 01.07.2020.
//  Copyright © 2020 Exey Panteleev. All rights reserved.
//

import Foundation

class SwiftSuffixArrayManipulator: SuffixArrayManipulator {
    var tupleSuffixArray = [(suffix: SuffixSequence, name: String)]()
    
    fileprivate let generator = StringGenerator()
    
    func dictHasEntries() -> Bool {
        !self.tupleSuffixArray.isEmpty
    }
    
    //MARK: Setup
    
    func setupWithObjectCount(_ count: Int) -> TimeInterval {
        return Profiler.runClosureForTime() {
            for _ in 0 ..< count {
                guard let item = self.getAllTuplesWithSort().randomElement() else { return }
                self.tupleSuffixArray.append(item)
            }
        }
    }
    
    //MARK: Adding entries
    
    func addEntries(_ count: Int) -> TimeInterval {
        var array = [(suffix: SuffixSequence, name: String)]()
        for _ in 0 ..< count {
            guard let item = self.getAllTuplesWithSort().randomElement() else { break }
            array.append(item)
        }
        
        let time = Profiler.runClosureForTime() {
            for tuple in array {
                self.tupleSuffixArray.append((suffix: tuple.suffix, tuple.name))
            }
        }
        
        //Restore to original state
        for tuple in array {
            guard let index = self.tupleSuffixArray.lastIndex(where: { $0.name == tuple.name }) else { break }
            self.tupleSuffixArray.remove(at: index)
        }
        
        return time
    }
    
    func add1Entry() -> TimeInterval {
        
        return addEntries(1)
    }
    func add5Entries() -> TimeInterval {
        
        return addEntries(5)
    }
    func add10Entries() -> TimeInterval {
        
        return addEntries(10)
    }
    
    //MARK: Removing entries
    
    func removeEntries(_ count: Int) -> TimeInterval {
        var array = [(suffix: SuffixSequence, name: String)]()
        for _ in 0 ..< count {
            guard let item = self.getAllTuplesWithSort().randomElement() else { break }
            array.append(item)
        }
        
        for tuple in array {
            self.tupleSuffixArray.append((suffix: tuple.suffix, tuple.name))
        }
        
        return Profiler.runClosureForTime() {
            //Restore to original state
            for tuple in array {
                guard let index = self.tupleSuffixArray.lastIndex(where: { $0.name == tuple.name }) else { break }
                self.tupleSuffixArray.remove(at: index)
            }
        }
    }
    
    func remove1Entry() -> TimeInterval {
        
        return removeEntries(1)
    }
    
    func remove5Entries() -> TimeInterval {
        
        return removeEntries(5)
    }
    
    func remove10Entries() -> TimeInterval {
        
        return removeEntries(10)
    }
    
    //MARK: Looking up entries
    
    func lookupEntries(_ count: Int) -> TimeInterval {
        var array = [(suffix: SuffixSequence, name: String)]()
        for i in 0 ..< count {
            guard let item = self.getAllTuplesWithSort().randomElement() else { break }
            array.append((suffix: item.suffix, name: item.name + i.description))
        }
        
        for tuple in array {
            self.tupleSuffixArray.append((suffix: tuple.suffix, tuple.name))
        }
        
        let time = Profiler.runClosureForTime() {
            //Look up by key
            for tuple in array {
                guard let index = self.tupleSuffixArray.lastIndex(where: { $0.name == tuple.name }) else { break }
                let _ = self.tupleSuffixArray[index]
            }
        }
        
        //Restore to original state
        for tuple in array {
            guard let index = self.tupleSuffixArray.lastIndex(where: { $0.name == tuple.name }) else { break }
            self.tupleSuffixArray.remove(at: index)
        }
        
        return time
    }
    
    func lookup1EntryTime() -> TimeInterval {
        
        return lookupEntries(1)
    }
    
    func lookup10EntriesTime() -> TimeInterval {
        
        return lookupEntries(10)
    }
    
    func searchEntries(_ count: Int) -> (time: TimeInterval, count: Int) {
        var array = [String]()
        var countFound = Int()
        for _ in 0 ..< count {
            array.append(self.generator.generateRandomString(3))
        }
        
        let time = Profiler.runClosureForTime() {
            for key in array {
                let _ = self.tupleSuffixArray.filter { item in
                    var testSuffixIterator = item.suffix.makeIterator()
                    var result = Bool()
                    while let suf = testSuffixIterator.next() {
                        
                        if suf == key {
                            countFound += 1
                            result = true
                            break
                        }
                    }
                    
                    return result
                }
            }
        }
        
        return (time, countFound)
    }
    
    func search10Entries() -> (time: TimeInterval, count: Int) {
        
        return searchEntries(10)
    }
    
    fileprivate func getAllTuplesWithSort() -> [(suffix: SuffixSequence, name: String)] {
        //Создание массива картежей из суффиксов и имен, сортировка по алфавиту всех элементов этого массива
        let tupleArray = AlgoProvider().all.compactMap( { (suffix: SuffixSequence(text: $0), name: $0) } ).sorted(by: { $0.name > $1.name })
        
        return tupleArray
    }
}
