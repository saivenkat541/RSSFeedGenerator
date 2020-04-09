//
//  FeedGeneratorTests.swift
//  RSSFeedGeneratorTests
//
//  Created by Sai Venkat Kancharlapalli on 4/8/20.
//  Copyright © 2020 Sai Venkat Kancharlapalli. All rights reserved.
//

import Foundation
import XCTest
@testable import RSSFeedGenerator

class FeedGeneratorTests: XCTestCase {
    func testAddResults() {
        let vc = RssFeedViewController()
        var result = vc.cellResults
        XCTAssertTrue(vc.cellResults.count == 0)
        result.append(Results(artistName: "Name", id: "1", releaseDate: "01-01-2020", name: "Name", kind: "Music", copyright: "@copyright", artistId: "1", contentAdvisoryRating: "explicit", artistUrl: "https://www.example.com", artworkUrl100: "https://www.example.com", genres: nil, url: "https://www.example.com"))
        XCTAssertTrue(result.count > 0)
    }
    
    func testGenreResult() {
        let vc = RssDetailViewController()
        var genre1 = vc.genreName
        XCTAssertTrue(vc.genreName.count == 0)
        genre1.append("Genre1")
        XCTAssertTrue(genre1.count > 0)
    }
    
    func testPerformanceExample() {
           self.measure {
               // Put the code you want to measure the time of here.
            testAddResults()
            testGenreResult()
           }
       }
}

