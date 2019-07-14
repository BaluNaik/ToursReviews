//
//  TRListPresenterIO.swift
//  ToursReviews
//
//  Created by Balu Naik on 7/13/19.
//  Copyright © 2019 Balu Naik. All rights reserved.
//

import Foundation



protocol TRListPresenterInput {
    
    func eventLoad()
    func getNumberOfRows() -> Int
    func getReviewAtIndex(_ index: Int) -> TRReview?
    func isLoaderCell(_ index: Int) -> Bool
    func loadNextPage()
    func changeSortTypeAndDirection(type: TRSortType, direction: TRSortDirection)
    func getCurrentSortDirectionType() -> TRSortDirection
    func changeSortDirection()

}


protocol TRListPresenterOutput: class {
    
    func showError(_ message: String)
    func showLoader(_ status: Bool)
    func updateList()
    
}
