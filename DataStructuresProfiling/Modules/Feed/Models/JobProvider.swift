//
//  JobProvider.swift
//  DataStructuresProfiling
//
//  Created by Роман on 19.07.2020.
//  Copyright © 2020 Exey Panteleev. All rights reserved.
//

import Foundation

protocol Manipulator {
    func setupWithObjectCount(_ count: Int) -> TimeInterval
}

struct JobQueue {
    var manipulator: Manipulator
    var quque: DispatchQueue
}

class JobScheduler {
    var timeIntervals: [(timeInterval: TimeInterval, queue: DispatchQueue)] = []
    
    func getTimeIntervals() -> [TimeInterval] {
        return self.jobData().compactMap { item in
            item.quque.sync {

                return item.manipulator.setupWithObjectCount(1000)
            }
        }
    }
    
    private func jobData() -> [JobQueue] {
        return [
            JobQueue(manipulator: SwiftArrayManipulator(), quque: .global()),
            JobQueue(manipulator: SwiftSetManipulator(), quque: .global()),
            JobQueue(manipulator: SwiftDictionaryManipulator(), quque: .global()),
            JobQueue(manipulator: SwiftSuffixArrayManipulator(), quque: .global())
        ]
    }
}
