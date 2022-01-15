//
//  RoundedImageView.swift
//  NYTimes
//
//  Created by Adithya Bhat on 15/01/2022.
//

import Foundation
import UIKit

class RoundedImageView: UIImageView {
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.layer.masksToBounds = true
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.layer.cornerRadius = self.bounds.width / 2.0
    }
}
