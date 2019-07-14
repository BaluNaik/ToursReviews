//
//  TRListPresenter.swift
//  ToursReviews
//
//  Created by Balu Naik on 7/13/19.
//  Copyright © 2019 Balu Naik. All rights reserved.
//

import UIKit

class TRListPresenter: NSObject,TRListPresenterInput, TRListInteractorOutput {
    
    weak var userInterface: TRListPresenterOutput?
    var interactor: TRListInteractorInput?
    
    
    //MARK: - TRListPresenterInput
    
    func eventLoad() {
        self.userInterface?.showLoader(true)
        self.interactor?.eventLoad()
    }
    
    func getNumberOfRows() -> Int {
        
        return self.interactor?.getNumberOfRows() ?? 0
    }
    
    func getReviewAtIndex(_ index: Int) -> TRReview? {
        
        return self.interactor?.getReviewAtIndex(index)
    }
    
    func isLoaderCell(_ index: Int) -> Bool {
        
        return self.interactor?.isLoaderCell(index) ?? false
    }
    
    func loadNextPage() {
        self.interactor?.loadNextPage()
    }
    
    func changeSortTypeAndDirection(type: TRSortType, direction: TRSortDirection) {
        self.userInterface?.showLoader(true)
        self.interactor?.changeSortTypeAndDirection(type: type, direction: direction)
    }
    
    func getCurrentSortDirectionType() -> TRSortDirection {
        
        return self.interactor?.getCurrentSortDirectionType() ?? TRSortDirection.OrderDesc
    }
    
    func changeSortDirection() {
        self.userInterface?.showLoader(true)
        self.interactor?.changeSortDirection()
    }
    
    
    //MARK: - TRListInteractorOutput
    
    func showError(_ message: String) {
        self.userInterface?.showLoader(false)
        self.userInterface?.showError(message);
    }
    
    func updateList() {
        self.userInterface?.showLoader(false)
        self.userInterface?.updateList()
    }
    
    
}

