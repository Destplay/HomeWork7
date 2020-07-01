//
//  FeedViewController.swift
//  OTUS
//
//  Created by Дмитрий Матвеенко on 01/06/2019.
//  Copyright © 2019 GkFoxes. All rights reserved.
//

import UIKit

class FeedViewController: UIViewController {
    
    @IBOutlet weak var feedTableView: UITableView!
    
    fileprivate let feedData = Services.feedProvider.feedMockData()
    fileprivate var filteredFeedData = [FeedData]()
    private let searchController = UISearchController(searchResultsController: nil)
    private var searchBarIsEmpty: Bool {
        guard let text = self.searchController.searchBar.text else { return false }
        return text.isEmpty
    }
    private var isFiltering: Bool {
        return self.searchController.isActive && !searchBarIsEmpty
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.searchController.searchResultsUpdater = self
        self.searchController.obscuresBackgroundDuringPresentation = false
        self.searchController.searchBar.placeholder = "Поиск"
        self.navigationItem.searchController = self.searchController
        self.definesPresentationContext = true
    }
}

extension FeedViewController: UITableViewDataSource {
    
    // MARK: - Table View Data Source
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if self.isFiltering {
            
            return self.filteredFeedData.count
        }
        
        return self.feedData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var item: FeedData

        if isFiltering {
            item = self.filteredFeedData[indexPath.row]
        } else {
            item = self.feedData[indexPath.row]
        }
        
        let cell = self.feedTableView.dequeueReusableCell(withIdentifier: FeedTableViewCell.reuseID, for: indexPath) as? FeedTableViewCell
        guard let feedCell = cell else { return UITableViewCell() }
        
        feedCell.updateCell(name: item.name)
        
        return feedCell
    }
}

extension FeedViewController: UITableViewDelegate {
    
    // MARK: - Table View Delegate
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        var vc: UIViewController?
        
        if let currentCell = tableView.cellForRow(at: indexPath) as? FeedTableViewCell, let name = currentCell.nameLabel.text {
            switch name {
                case "Array":
                    let storyboard = UIStoryboard(name: "DataStructures", bundle: nil)
                    vc = storyboard.instantiateViewController(withIdentifier: "ArrayViewController")
                case "Set":
                    let storyboard = UIStoryboard(name: "DataStructures", bundle: nil)
                    vc = storyboard.instantiateViewController(withIdentifier: "SetViewController")
                case "Dictionary":
                    let storyboard = UIStoryboard(name: "DataStructures", bundle: nil)
                    vc = storyboard.instantiateViewController(withIdentifier: "DictionaryViewController")
                case "SuffixArray":
                    let storyboard = UIStoryboard(name: "DataStructures", bundle: nil)
                    vc = storyboard.instantiateViewController(withIdentifier: "SuffixArrayViewController")
                default:
                    let storyboard = UIStoryboard(name: "Feed", bundle: nil)
                    vc = storyboard.instantiateViewController(withIdentifier: "SessionSummaryViewController")
            }
        }
        
        
        if let pushViewController = vc {
            self.navigationController?.pushViewController(pushViewController, animated: true)
        }
    }
}

extension FeedViewController: UISearchResultsUpdating {
    
    func updateSearchResults(for searchController: UISearchController) {
        self.filterContentForSearchText(searchController.searchBar.text ?? "")
    }
    
    private func filterContentForSearchText(_ searchText: String) {
        
        self.filteredFeedData = feedData.filter({ (restaurant: FeedData) -> Bool in
            return restaurant.name.lowercased().contains(searchText.lowercased())
        })
        
        self.feedTableView.reloadData()
    }
}
