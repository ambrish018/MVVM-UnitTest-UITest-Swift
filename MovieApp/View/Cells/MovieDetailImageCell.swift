//
//  MovieDetailImageCell.swift
//  MovieApp
//
//  Created by YASH COMPUTERS on 31/08/19.
//  Copyright © 2019 ambrish. All rights reserved.
//

import UIKit

class MovieDetailImageCell: UITableViewCell {

    @IBOutlet weak var posterImageView: UIImageView!
    
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var LanguageLabel: UILabel!
    @IBOutlet weak var releaseLabel: UILabel!
    @IBOutlet weak var popularityLabel: UILabel!
    @IBOutlet weak var votesLabel: UILabel!
    @IBOutlet weak var durationLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func configureCell(model: MovieDetailImageCellModel) {
        
        self.ratingLabel?.text = model.voteAverage
        self.votesLabel.text = model.numberOfVotes
        self.LanguageLabel.text = model.language
        self.releaseLabel.text = model.releaseDate
        self.popularityLabel.text = model.ratingScore
        self.durationLabel.text = model.runningTime
//        self.voteLabel.text = model.voteAverage
        guard let imageUrlStr = model.moviePoster500 else{
            return
        }
        guard let url = URL(string: imageUrlStr) else {
            return
        }
        self.posterImageView.kf.setImage(with: url)
        
    }

}

