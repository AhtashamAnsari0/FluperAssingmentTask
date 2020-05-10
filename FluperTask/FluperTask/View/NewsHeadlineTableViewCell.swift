//
//  NewsHeadlineTableViewCell.swift
//  FluperTask
//
//  Created by Ahtasham Ansari on 10/05/20.
//  Copyright © 2020 AhtashamAnsari. All rights reserved.
//

import UIKit

class NewsHeadlineTableViewCell: UITableViewCell {

    /** UIImageView for showing image for top headline */
    @IBOutlet private weak var newsImage: UIImageView!

    /** UILabel for showing title for top headline */
    @IBOutlet private weak var newsTitleLable: UILabel!
   
    /** UILabel for showing description for top headline. */
    @IBOutlet private weak var newsDescriptionLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configureCell(newsArticle: TopHeadlineViewModal) {
        self.newsTitleLable.text = newsArticle.title
        self.newsDescriptionLabel.text = newsArticle.newsDescription
        if let imageUrl = newsArticle.imageUrl {
            LoadImage.sharedLoader.imageFromUrl(urlString: imageUrl) { [weak self] (image, imageUrl) in

                DispatchQueue.main.async {
                    self?.newsImage.image = image
                }
            }
        }else {
            self.newsImage.image = UIImage(named: "ic_news_logo")
        }
    }
    
}
