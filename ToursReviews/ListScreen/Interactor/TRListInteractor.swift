//
//  TRListInteractor.swift
//  ToursReviews
//
//  Created by Balu Naik on 7/13/19.
//  Copyright © 2019 Balu Naik. All rights reserved.
//

import UIKit
import SwiftyJSON
import ObjectMapper

enum TRSortType: String {
    case date = "date_of_review"
    case rating = "rating"
}

enum TRSortDirection: String {
    case OrderAsc = "asc"
    case OrderDesc = "desc"
}

class TRListInteractor: NSObject, TRListInteractorInput  {
    
    weak var presenter: TRListInteractorOutput?
    var connector = TRNetworkConnector()
    var totalReviews = 0
    var reviewsList: [TRReview] = []
    private let reviewsPerPage = 5
    private var currentPage = 0
    private var incrementalFetchInProgress = false
    private var sortType: TRSortType = .date
    private var sortDirection: TRSortDirection = .OrderDesc
    
    
    //MARK: - Private
    
    private func isPaginationEnabled() -> Bool {
        
        return self.reviewsList.count != totalReviews
    }
    
    private func shouldShowPaginationLoader() -> Int {
        
        return self.isPaginationEnabled() ? 1 : 0
    }
    
    
    //MARK: TRListInteractorInput
    
    func eventLoad() {
        if !TRNetworkWrapper.isConnectedToInternet {
            self.presenter?.showError("Please check your network connection and try later")
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
                exit(1)
            }
        }
        self.connector.perforGetRequest(pageCount: reviewsPerPage, pageIndex: self.currentPage, sortBy: self.sortType.rawValue, sortDirection: self.sortDirection.rawValue, success: { (response) in
            if let responseObj = response {
                if let reviews = Mapper<TRReviews>().map(JSONObject: responseObj) {
                    if let total = reviews.totalReviewsComments {
                        self.totalReviews = total
                    }
                    if let list = reviews.reviews {
                        self.reviewsList = list
                    }
                }
                self.presenter?.updateList()
            }
            
        }) { (response) in
            if let error = response as? Error {
                self.presenter?.showError(error.localizedDescription)
            }
        }
    }
    
    func getNumberOfRows() -> Int {
        
        return self.reviewsList.count + self.shouldShowPaginationLoader()
    }
    
    func getReviewAtIndex(_ index: Int) -> TRReview? {
        
        return self.reviewsList[index]
    }
    
    func isLoaderCell(_ index: Int) -> Bool {
        
        return index >= self.reviewsList.count
    }
    
    func loadNextPage() {
        if incrementalFetchInProgress {
            
            return
        }
        if !TRNetworkWrapper.isConnectedToInternet {
            self.presenter?.showError("Please check your network connection and try later")
            
            return
        }
        self.currentPage+=1
        self.incrementalFetchInProgress = true
        self.connector.perforGetRequest(pageCount: reviewsPerPage, pageIndex: self.currentPage, sortBy: self.sortType.rawValue, sortDirection: self.sortDirection.rawValue, success: { (response) in
            if let responseObj = response {
                if let reviews = Mapper<TRReviews>().map(JSONObject: responseObj) {
                    if let total = reviews.totalReviewsComments {
                        self.totalReviews = total
                    }
                    if let list = reviews.reviews {
                        self.reviewsList.append(contentsOf: list)
                    }
                }
                self.presenter?.updateList()
                self.incrementalFetchInProgress = false
            }
        }) { (response) in
            self.incrementalFetchInProgress = false
            if let error = response as? Error {
                self.presenter?.showError(error.localizedDescription)
            }
        }
    }
    
    func changeSortTypeAndDirection(type: TRSortType, direction: TRSortDirection) {
        self.sortType = type
        self.sortDirection = direction
        self.reviewsList.removeAll()
        self.currentPage = 0
        self.eventLoad()
    }
    
    func getCurrentSortDirectionType() -> TRSortDirection {
        
        return self.sortDirection
    }
    
    func changeSortDirection() {
        self.sortDirection =  (self.sortDirection == .OrderAsc ? .OrderDesc: .OrderAsc)
        self.reviewsList.removeAll()
        self.currentPage = 0
        self.eventLoad()
    }
}
