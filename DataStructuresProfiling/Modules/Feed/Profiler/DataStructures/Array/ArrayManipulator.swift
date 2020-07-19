//
//  ArrayManipulator.swift
//  DataStructures
//
//  Created by Ellen Shapiro on 8/2/14.
//  Copyright (c) 2014 Ray Wenderlich Tutorial Team. All rights reserved.
//

import Foundation

/**
 * A protocol which will allow the easy swapping out of array subtypes
 */
protocol ArrayManipulator: Manipulator {
    func arrayHasObjects() -> Bool
    func insertNewObjectAtBeginning() -> TimeInterval
    func insertNewObjectInMiddle() -> TimeInterval
    func addNewObjectAtEnd() -> TimeInterval 
    func removeFirstObject() -> TimeInterval 
    func removeMiddleObject() -> TimeInterval
    func removeLastObject() -> TimeInterval
    func lookupByIndex() -> TimeInterval
    func lookupByObject() -> TimeInterval
}
