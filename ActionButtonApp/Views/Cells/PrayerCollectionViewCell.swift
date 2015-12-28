//
//  PrayerCollectionViewCell.swift

//  Copyright (c) 2015-2016 Teklabs, LLC. All rights reserved.
//

import UIKit

class PrayerCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var prayerTitle: UILabel!
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
        
        prayerTitle.textColor = UIColor.cellLabelColor()
        userName.textColor = UIColor.cellLabelColor()
        viewLabel.textColor = UIColor.cellLabelColor()
        viewUnitLabel.textColor = UIColor.cellLabelColor()
    }
}
