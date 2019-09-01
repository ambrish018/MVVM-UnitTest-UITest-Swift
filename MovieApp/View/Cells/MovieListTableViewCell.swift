//
//  MovieListTableViewCell.swift
//  MovieApp
//
//  Created by YASH COMPUTERS on 29/08/19.
//  Copyright © 2019 ambrish. All rights reserved.
//

import UIKit
import Kingfisher
class MovieListTableViewCell: UITableViewCell {

    @IBOutlet weak var postImage: UIImageView!
    
    @IBOutlet weak var movieTitleLabel: UILabel!
    
    @IBOutlet weak var voteLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configureCell(model: MovieCellDataModel) {

        self.movieTitleLabel?.text = model.movieTitle
        self.voteLabel.text = model.voteAverage
        guard let imageUrlStr = model.moviePoster200 else{
            return
        }
        guard let url = URL(string: imageUrlStr) else {
            return
        }
        self.postImage.kf.setImage(with: url)

    }

}
