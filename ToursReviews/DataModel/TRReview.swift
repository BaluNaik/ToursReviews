//
//  TRReview.swift
//  ToursReviews
//
//  Created by Balu Naik on 7/13/19.
//  Copyright © 2019 Balu Naik. All rights reserved.
//

import Foundation
import ObjectMapper

class TRReview : Mappable {
    
    var review_id : Int?
    var rating : String?
    var title : String?
    var message : String?
    var author : String?
    var foreignLanguage : Bool?
    var date : String?
    var languageCode : String?
    var traveler_type : String?
    var reviewerName : String?
    var reviewerCountry : String?
    var reviewerProfilePhoto : String?
    var isAnonymous : Bool?
    var firstInitial : String?
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        review_id <- map["review_id"]
        rating <- map["rating"]
        title <- map["title"]
        message <- map["message"]
        author <- map["author"]
        foreignLanguage <- map["foreignLanguage"]
        date <- map["date"]
        languageCode <- map["languageCode"]
        traveler_type <- map["traveler_type"]
        reviewerName <- map["reviewerName"]
        reviewerCountry <- map["reviewerCountry"]
        reviewerProfilePhoto <- map["reviewerProfilePhoto"]
        isAnonymous <- map["isAnonymous"]
        firstInitial <- map["firstInitial"]
    }
}
