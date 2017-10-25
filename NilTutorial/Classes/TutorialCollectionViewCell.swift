//
//  TutorialCollectionViewCell.swift
//  NilPageView
//
//  Created by Tanasak Ngerniam on 9/11/2560 BE.
//  Copyright © 2560 NilNolan. All rights reserved.
//

import UIKit

class TutorialCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var imageView:UIImageView!

    static let cellIdentifier  = "TutorialCollectionViewCell"

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.preservesSuperviewLayoutMargins = false
        self.layoutMargins = .zero
    }

}
