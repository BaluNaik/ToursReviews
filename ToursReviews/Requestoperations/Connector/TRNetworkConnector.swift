//
//  TRNetworkConnector.swift
//  ToursReviews
//
//  Created by Balu Naik on 7/13/19.
//  Copyright © 2019 Balu Naik. All rights reserved.
//

import Foundation

class TRNetworkConnector: NSObject {
    
    func perforGetRequest(pageCount: Int, pageIndex: Int, sortBy: String,  sortDirection: String,  success successBlock: @escaping ((Any?) -> Void), failure failureBlock: @escaping ((Any?) -> Void)) {
        let parms: [String: Any] = ["count": pageCount,
                                    "page":pageIndex,
                                    "sortBy":sortBy,
                                    "direction":sortDirection]
        TRNetworkWrapper.performGetRequest(TRServiceURL.URL_REVIEW, requestParameters: parms, httpHeaderFields: [:], success: { (response) in
            successBlock(response)
        }) { (error) in
            failureBlock(error)
        }
    }
}
