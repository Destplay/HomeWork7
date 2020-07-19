//
//  SuffixArrayViewController.swift
//  DataStructuresProfiling
//
//  Created by Роман on 01.07.2020.
//  Copyright © 2020 Exey Panteleev. All rights reserved.
//

import UIKit

private enum SuffixArrayVCRow: Int {
    case creation = 0,
    add1Entry,
    add5Entries,
    add10Entries,
    remove1Entry,
    remove5Entries,
    remove10Entries,
    lookup1Entry,
    lookup10Entries,
    search10EntriesTime,
    search10EntriesCount
}

class SuffixArrayViewController: DataStructuresViewController {
    
    //MARK: - Variables
    
    let suffixArrayManipulator: SuffixArrayManipulator = SwiftSuffixArrayManipulator()
    
    var creationTime: TimeInterval = 0
    var add1EntryTime: TimeInterval = 0
    var add5EntriesTime: TimeInterval = 0
    var add10EntriesTime: TimeInterval = 0
    var remove1EntryTime: TimeInterval = 0
    var remove5EntriesTime: TimeInterval = 0
    var remove10EntriesTime: TimeInterval = 0
    var lookup1EntryTime: TimeInterval = 0
    var lookup10EntriesTime: TimeInterval = 0
    var search10EntriesTime: TimeInterval = 0
    var countFound: Int = 0
    
    //MARK: - Methods
    
    //MARK: View lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.createAndTestButton.setTitle("Create SuffixArray and Test", for: UIControl.State())
    }
    
    //MARK: Superclass creation/testing overrides
    
    override func create(_ size: Int) {
        self.creationTime = self.suffixArrayManipulator.setupWithObjectCount(size)
    }
    
    override func test() {
        if self.suffixArrayManipulator.dictHasEntries() {
            self.add1EntryTime = self.suffixArrayManipulator.add1Entry()
            self.add5EntriesTime = self.suffixArrayManipulator.add5Entries()
            self.add10EntriesTime = self.suffixArrayManipulator.add10Entries()
            self.remove1EntryTime = self.suffixArrayManipulator.remove1Entry()
            self.remove5EntriesTime = self.suffixArrayManipulator.remove5Entries()
            self.remove10EntriesTime = self.suffixArrayManipulator.remove10Entries()
            self.lookup1EntryTime = self.suffixArrayManipulator.lookup1EntryTime()
            self.lookup10EntriesTime = self.suffixArrayManipulator.lookup10EntriesTime()
            self.search10EntriesTime = self.suffixArrayManipulator.search10Entries().time
            self.countFound = self.suffixArrayManipulator.search10Entries().count
        } else {
            print("SuffixArray not yet set up!")
        }
    }
    
    //MARK: Table View Override
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = super.tableView(tableView, cellForRowAt: indexPath)
        
        switch (indexPath as NSIndexPath).row {
            case SuffixArrayVCRow.creation.rawValue:
                cell.textLabel?.text = "SuffixArray Creation:"
                cell.detailTextLabel?.text = formattedTime(self.creationTime)
            case SuffixArrayVCRow.add1Entry.rawValue:
                cell.textLabel?.text = "Add 1 Entry:"
                cell.detailTextLabel?.text = formattedTime(self.add1EntryTime)
            case SuffixArrayVCRow.add5Entries.rawValue:
                cell.textLabel?.text = "Add 5 Entries:"
                cell.detailTextLabel?.text = formattedTime(self.add5EntriesTime)
            case SuffixArrayVCRow.add10Entries.rawValue:
                cell.textLabel?.text = "Add 10 Entries:"
                cell.detailTextLabel?.text = formattedTime(self.add10EntriesTime)
            case SuffixArrayVCRow.remove1Entry.rawValue:
                cell.textLabel?.text = "Remove 1 Entry:"
                cell.detailTextLabel?.text = formattedTime(self.remove1EntryTime)
            case SuffixArrayVCRow.remove5Entries.rawValue:
                cell.textLabel?.text = "Remove 5 Entries:"
                cell.detailTextLabel?.text = formattedTime(self.remove5EntriesTime)
            case SuffixArrayVCRow.remove10Entries.rawValue:
                cell.textLabel?.text = "Remove 10 Entries:"
                cell.detailTextLabel?.text = formattedTime(self.remove10EntriesTime)
            case SuffixArrayVCRow.lookup1Entry.rawValue:
                cell.textLabel?.text = "Lookup 1 Entry:"
                cell.detailTextLabel?.text = formattedTime(self.lookup1EntryTime)
            case SuffixArrayVCRow.lookup10Entries.rawValue:
                cell.textLabel?.text = "Lookup 10 Entries:"
                cell.detailTextLabel?.text = formattedTime(self.lookup10EntriesTime)
            case SuffixArrayVCRow.search10EntriesTime.rawValue:
                cell.textLabel?.text = "Search 10 Entries:"
                cell.detailTextLabel?.text = formattedTime(self.search10EntriesTime)
            case SuffixArrayVCRow.search10EntriesCount.rawValue:
                cell.textLabel?.text = "Number of coincidences:"
                cell.detailTextLabel?.text = self.countFound.description
            default:
                print("Unhandled row! \((indexPath as NSIndexPath).row)")
        }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 11
    }
}
