//
//  MovieDetailOverviewTableViewCell.swift
//  MovieApp
//
//  Created by YASH COMPUTERS on 31/08/19.
//  Copyright © 2019 ambrish. All rights reserved.
//

import UIKit

class MovieDetailOverviewTableViewCell: UITableViewCell {
    @IBOutlet weak var overViewLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func configureCell(overview:String){
        self.overViewLabel.text = overview
    }

}

class MovieDetailGenresTableViewCell: UITableViewCell {
    
    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var genereLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    func configureCell(model : MovieDetailGenereCellModel){
        self.categoryLabel.text = model.categoryLabelTitle
        self.genereLabel.text = model.generes
    }
    
}
