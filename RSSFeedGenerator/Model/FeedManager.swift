//
//  FeedManager.swift
//  RSSFeedGenerator
//
//  Created by Sai Venkat Kancharlapalli on 4/6/20.
//  Copyright © 2020 Sai Venkat Kancharlapalli. All rights reserved.
//

import Foundation

// MARK: - FeedManager Protocol
protocol FeedManagerDelegate {
    func didUpdateFeed(_ feedManager: FeedManager, feed : Feed)
    func didFailWithError(error: Error)
}

struct FeedManager {
    let feedURL = Constants.apiURL
    var delegate : FeedManagerDelegate?
    
    func fetchFeed() {
        let urlString = "\(feedURL)"
        performRequest(with: urlString)
    }
    
    func performRequest(with urlString: String) {
        //Step 1 : Create URL
        if let url = URL(string: urlString) {
            
            //Step 2 : Create a URL session
            let session = URLSession(configuration: .default)
            
            //Step 3 : Give URLSession a task
            let task = session.dataTask(with: url) { (data, response, error) in
                if error != nil {
                    print(error!)
                    self.delegate?.didFailWithError(error: error!)
                    return
                }
                
                if let safeData = data {
                    if let feedData = self.parseJSON(safeData) {
                        self.delegate?.didUpdateFeed(self, feed : feedData)
                    }
                }
            }
            //Step 4 : Start the task
            task.resume()
        }
    }
    
    // MARK: - Parse JSON Data
    func parseJSON(_ feedData : Data) -> Feed? {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        do {
            let decodedData = try decoder.decode(FeedData.self, from: feedData)
            return decodedData.feed
        }
        catch {
            print(error)
            delegate?.didFailWithError(error: error)
            return nil
        }
    }
}
