//
//  ShotCollectionViewCell.swift
//  DribbbleReader
//
//  Created by naoyashiga on 2015/05/17.
//  Copyright (c) 2015年 naoyashiga. All rights reserved.
//

import UIKit

class NotificationCollectionViewCell: UICollectionViewCell {
    //@IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var notificationTitle: UILabel!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var userIcon: UIImageView!
    @IBOutlet weak var viewLabel: UILabel!
    @IBOutlet weak var viewUnitLabel: UILabel!

//    @IBOutlet weak var animatedImageView: FLAnimatedImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.translatesAutoresizingMaskIntoConstraints = false
        
        self.layer.cornerRadius = 3
        self.layer.masksToBounds = true
        
        notificationTitle.textColor = UIColor.cellLabelColor()
        userName.textColor = UIColor.cellLabelColor()
        viewLabel.textColor = UIColor.cellLabelColor()
        viewUnitLabel.textColor = UIColor.cellLabelColor()
    }
}
