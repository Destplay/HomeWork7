//
//  SuffixArrayManipulator.swift
//  DataStructuresProfiling
//
//  Created by Роман on 01.07.2020.
//  Copyright © 2020 Exey Panteleev. All rights reserved.
//

import Foundation

/**
 * A protocol which will allow the easy swapping out of dictionary subtypes
 */
protocol SuffixArrayManipulator {
    func dictHasEntries() -> Bool
    func setupWithEntryCount(_ count: Int) -> TimeInterval
    func add1Entry() -> TimeInterval
    func add5Entries() -> TimeInterval
    func add10Entries() -> TimeInterval
    func remove1Entry() -> TimeInterval
    func remove5Entries() -> TimeInterval
    func remove10Entries() -> TimeInterval
    func lookup1EntryTime() -> TimeInterval
    func lookup10EntriesTime() -> TimeInterval
    func search10Entries() -> (time: TimeInterval, count: Int)
}
