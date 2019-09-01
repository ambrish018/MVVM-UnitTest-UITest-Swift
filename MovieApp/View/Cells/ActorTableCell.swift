//
//  ActorTableCell.swift
//  MovieApp
//
//  Created by YASH COMPUTERS on 31/08/19.
//  Copyright © 2019 ambrish. All rights reserved.
//

import UIKit

class ActorTableCell: UITableViewCell {

    @IBOutlet weak var actorProfileImageView: UIImageView!
    
    @IBOutlet weak var characterName: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func configure(actorModel:ActorCellModel){
        self.characterName.text = actorModel.nameAndCharacter
        guard let imageUrlStr = actorModel.profileImage else{
            return
        }
        guard let url = URL(string: imageUrlStr) else {
            return
        }
        self.actorProfileImageView.kf.setImage(with: url)
    }

}
