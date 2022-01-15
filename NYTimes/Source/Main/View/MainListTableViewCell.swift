//
//  MainListTableViewCell.swift
//  NYTimes
//
//  Created by Adithya Bhat on 14/01/2022.
//

import UIKit
import AlamofireImage

class MainListTableViewCell: UITableViewCell {

    //MARK: - Properties
    
    @IBOutlet weak var thumbnailImageView: RoundedImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subtitleLabel: UILabel!
    @IBOutlet weak var footerLabel: UILabel!

}

extension MainListTableViewCell {
    
    private var dateFormatter: DateFormatter {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd MMM yyyy"
        return dateFormatter
    }
    
    func setup(with article: Article) {
        titleLabel.text = article.title
        subtitleLabel.text = article.byLine
        footerLabel.text = dateFormatter.string(from: article.publishDate)
        if let url = URL(string: article.imageURL) {
            thumbnailImageView.af.setImage(withURL: url)
        }
    }
    
}
