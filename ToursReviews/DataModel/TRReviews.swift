//
//  TRReviews.swift
//  ToursReviews
//
//  Created by Balu Naik on 7/13/19.
//  Copyright © 2019 Balu Naik. All rights reserved.
//

import Foundation
import ObjectMapper

class TRReviews : Mappable {
    
    var status : Bool?
    var totalReviewsComments : Int?
    var reviews : [TRReview]?
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        
        status <- map["status"]
        totalReviewsComments <- map["total_reviews_comments"]
        reviews <- map["data"]
    }
}
