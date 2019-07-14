//
//  TRNetworkWrapper.swift
//  ToursReviews
//
//  Created by Balu Naik on 7/13/19.
//  Copyright © 2019 Balu Naik. All rights reserved.
//

import Foundation
import Alamofire

@objc public class TRNetworkWrapper: NSObject {
    
    class var isConnectedToInternet:Bool {
        
        return NetworkReachabilityManager()!.isReachable
    }

    
    @objc class func performGetRequest(_ requestUrl: String,
                                       requestParameters: [String:Any],
                                       httpHeaderFields: [String:String],
                                       success: @escaping (Any?) -> Void,
                                       failure: @escaping (Any?) -> Void) -> Void {
        Alamofire.request(requestUrl, method: .get, parameters: requestParameters, encoding: URLEncoding.default, headers: httpHeaderFields).validate().responseJSON { (response:DataResponse<Any>) in
            if let httpResponse = response.response, case 200 ... 399 = httpResponse.statusCode {
                success(response.result.value ?? [:] as Any)
            } else {
                failure(response.error)
            }
        }
    }
}

