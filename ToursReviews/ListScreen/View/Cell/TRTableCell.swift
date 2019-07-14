//
//  TRTableCell.swift
//  ToursReviews
//
//  Created by Balu Naik on 7/13/19.
//  Copyright © 2019 Balu Naik. All rights reserved.
//

import UIKit
import FontAwesome_swift

class TRTableCell: UITableViewCell {
    
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblReview: UILabel!
    @IBOutlet weak var lblDate: UILabel!
    @IBOutlet weak var lblMessage: UILabel!
    @IBOutlet weak var lblAuthor: UILabel!
    @IBOutlet weak var lblAuthName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        lblAuthName.layer.borderWidth = 1
        lblAuthName.layer.masksToBounds = false
        lblAuthName.layer.borderColor = UIColor.white.cgColor
        lblAuthName.layer.cornerRadius = lblAuthName.frame.height/2
        lblAuthName.clipsToBounds = true
    }
    
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func setUpDefaultSate() {
        self.lblTitle.text = ""
        self.lblReview.text = ""
        self.lblDate.text = ""
        self.lblMessage.text = ""
        self.lblAuthor.text = ""
    }
    
    func setReview(_ review: TRReview) {
        if let title = review.title {
            self.lblTitle?.text = title
        }
        if let ratingString = review.rating, let value = Double(ratingString) {
            self.lblReview?.attributedText = self.starRatingWith(filledStars: Int(value))
        }
        if let pubDate = review.date {
            self.lblDate.text = pubDate
        }
        if let message = review.message {
            self.lblMessage?.text = message
        }
        if let auth = review.author {
            self.lblAuthor.text = auth
            self.lblAuthName.text = String(auth[auth.startIndex]).uppercased()
        }
    }
    
    func starRatingWith(filledStars: Int) -> NSAttributedString {
        let fontAwesome = UIFont.fontAwesome(ofSize: 14.0, style: .solid)
        
        let activeStarFormatting: [NSAttributedString.Key : Any] = [NSAttributedString.Key.foregroundColor: UIColor(rgb: 0xFFD700), NSAttributedString.Key.font: fontAwesome];
        
        let inactiveStarFormatting: [NSAttributedString.Key : AnyObject] = [NSAttributedString.Key.foregroundColor: UIColor.lightGray, NSAttributedString.Key.font: fontAwesome];
        
        let attString = NSMutableAttributedString()
        for _ in 1...filledStars {
            attString.append(NSAttributedString(string: "\u{f005} ", attributes: activeStarFormatting))
        }
        let count = 5 - filledStars
        if count > 0  {
            for _ in 1...count {
                attString.append(NSAttributedString(string: "\u{f005} ", attributes: inactiveStarFormatting))
            }
        }
        
        return attString
    }
}



