//
//  TRListViewController.swift
//  ToursReviews
//
//  Created by Balu Naik on 7/13/19.
//  Copyright © 2019 Balu Naik. All rights reserved.
//

import UIKit
import SVProgressHUD

class TRListViewController: UIViewController, TRListPresenterOutput, UITableViewDataSource, UITableViewDelegate {
    
    var presenter : TRListPresenterInput?
    @IBOutlet weak var tbleView: UITableView!
    @IBOutlet weak var segmentSortType: UISegmentedControl!
    @IBOutlet weak var orderButton: UIButton!
    private var nextPageLoader: UIActivityIndicatorView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.presenter?.eventLoad()
    }
    
    @IBAction func actionOnSortTypeChange(_ sender: Any) {
        self.tbleView.scrollToRow(at: IndexPath(row: 0, section: 0), at: .top, animated: true)
        self.orderButton.setImage(UIImage(named: "descending"), for: .normal)
        self.presenter?.changeSortTypeAndDirection(type:(self.segmentSortType.selectedSegmentIndex == 0 ? TRSortType.date : TRSortType.rating), direction: TRSortDirection.OrderDesc)
    }
    
    @IBAction func actionOnSortDirectionChange(_ sender: Any) {
        if let currentSortDirection = self.presenter?.getCurrentSortDirectionType() {
            self.orderButton.setImage(UIImage(named:currentSortDirection == TRSortDirection.OrderAsc ? "descending" : "ascending"), for: .normal)
            self.presenter?.changeSortDirection()
        }
    }
    //MARK: - Private methods
    
    fileprivate func setupUI() {
        self.title = "Tours Reviews"
        tbleView.register(UINib(nibName: "TRTableCell", bundle: nil), forCellReuseIdentifier: "Cell")
        tbleView.register(UINib(nibName: "TRLoaderTableCell", bundle: nil), forCellReuseIdentifier: "LoaderCell")
        self.tbleView.estimatedRowHeight = 40.0
        self.tbleView.rowHeight = UITableView.automaticDimension
    }
    
    fileprivate func reloadData() {
        self.tbleView.reloadData()
    }
    
    
    //MARK: - UITableViewDelegate & UITableViewDataSource
    
    func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return self.presenter?.getNumberOfRows() ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = UITableViewCell()
        if let isLoderCell = self.presenter?.isLoaderCell(indexPath.row), isLoderCell,
            let loaderCell = tableView.dequeueReusableCell(withIdentifier:"LoaderCell") as? TRLoaderTableCell  {
            loaderCell.activityIndicatorView.startAnimating()
            cell = loaderCell
        } else if let customCell = tableView.dequeueReusableCell(withIdentifier:"Cell") as? TRTableCell {
            customCell.setUpDefaultSate()
            if let reviewObj = self.presenter?.getReviewAtIndex(indexPath.row) {
                customCell.setReview(reviewObj)
            }
            cell = customCell
        }
        cell.selectionStyle = .none
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if let isLoderCell = self.presenter?.isLoaderCell(indexPath.row), isLoderCell {
            self.presenter?.loadNextPage()
        }
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return indexPath.row >= (self.presenter?.getNumberOfRows() ?? 0) ? 40.0 : UITableView.automaticDimension
    }
    
    
    //MARK: TRListPresenterOutput
    
    func showError(_ message: String) {
        let alertController = UIAlertController(title: "ToursReviews", message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        self.present(alertController, animated: true, completion: nil)
    }
    
    func showLoader(_ status: Bool) {
        if status {
            SVProgressHUD.setDefaultStyle(.light)
            SVProgressHUD.setDefaultMaskType(.gradient)
            SVProgressHUD.setDefaultAnimationType(.native)
            SVProgressHUD.show(withStatus: "Loading..")
        } else {
            SVProgressHUD.dismiss()
        }
    }
    
    func updateList() {
        self.reloadData()
    }
    
}
