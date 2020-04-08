//
//  FeedData.swift
//  RSSFeedGenerator
//
//  Created by Sai Venkat Kancharlapalli on 4/6/20.
//  Copyright © 2020 Sai Venkat Kancharlapalli. All rights reserved.
//

import Foundation

struct FeedData: Codable {
    var feed : Feed
}

struct Feed : Codable {
    let title : String?
    let id : String?
    let author : Author?
    let links : [Links]?
    let copyright : String?
    let country : String?
    let icon : String?
    let updated : String?
    let results : [Results]?
}

struct Results : Codable {
    let artistName : String?
    let id : String?
    let releaseDate : String?
    let name : String?
    let kind : String?
    let copyright : String?
    let artistId : String?
    let contentAdvisoryRating : String?
    let artistUrl : String?
    let artworkUrl100 : String?
    let genres : [Genres]?
    let url : String?
}

struct Links : Codable {
    let `self` : String?
    //let alternate : String?
}

struct Genres : Codable {
    let genreId : String?
    let name : String?
    let url : String?
}

struct Author : Codable {
    let name : String?
    let uri : String?
}
