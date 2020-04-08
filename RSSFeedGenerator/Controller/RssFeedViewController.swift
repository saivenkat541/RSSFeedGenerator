//
//  RssFeedViewController.swift
//  RSSFeedGenerator
//
//  Created by Sai Venkat Kancharlapalli on 4/6/20.
//  Copyright © 2020 Sai Venkat Kancharlapalli. All rights reserved.
//

import UIKit

class RssFeedViewController: UIViewController {
    
    var feedManager = FeedManager()
    var feedResult : Feed? //model
    var cellResults : [Results] = [Results]() //Results array
    let feedTableView = UITableView() // view
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        view.addSubview(feedTableView)
        feedTableView.translatesAutoresizingMaskIntoConstraints = false
        feedTableView.topAnchor.constraint(equalTo:view.safeAreaLayoutGuide.topAnchor).isActive = true
        feedTableView.leftAnchor.constraint(equalTo:view.safeAreaLayoutGuide.leftAnchor).isActive = true
        feedTableView.rightAnchor.constraint(equalTo:view.safeAreaLayoutGuide.rightAnchor).isActive = true
        feedTableView.bottomAnchor.constraint(equalTo:view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        feedTableView.dataSource = self
        feedTableView.delegate = self
        feedTableView.register(FeedTableViewCell.self, forCellReuseIdentifier: Constants.cellReuseName)
        setUpNavigation()
        feedManager.delegate = self
        feedManager.fetchFeed()
    }
    // MARK: - Navigation Setup
    func setUpNavigation() {
        navigationItem.title = Constants.navBarTitleName
        self.navigationController?.navigationBar.barTintColor = #colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1)
        self.navigationController?.navigationBar.isTranslucent = false
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor(red: 1, green: 1, blue: 1, alpha: 1)]
    }
}

// MARK: - FeedManagerDelegate section
extension RssFeedViewController : FeedManagerDelegate {
    func didUpdateFeed(_ feedManager : FeedManager, feed : Feed) {
        DispatchQueue.main.async {
            self.feedResult = feed
            if let result = self.feedResult {
                self.cellResults = result.results!
                self.feedTableView.reloadData()
            }
        }
    }
    
    func didFailWithError(error: Error) {
        print(error)
    }
}

// MARK: - FeedTableView Delegate

extension RssFeedViewController : UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cellResults.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.cellReuseName, for: indexPath) as! FeedTableViewCell
        cell.contact = cellResults[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = RssDetailViewController()
        self.navigationController?.pushViewController(vc, animated: true)
        if let indexPath = feedTableView.indexPathForSelectedRow {
            vc.detailResults = cellResults[indexPath.row]
        }
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
