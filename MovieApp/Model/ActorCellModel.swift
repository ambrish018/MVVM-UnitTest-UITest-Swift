//
//  ActorCellModel.swift
//  MovieApp
//
//  Created by YASH COMPUTERS on 31/08/19.
//  Copyright © 2019 ambrish. All rights reserved.
//

import Foundation
class ActorCellModel {
    var nameAndCharacter : String?
    var profileImage : String?
    init(actorModel:Actor) {
        self.nameAndCharacter = "\(actorModel.name ?? "") as \(actorModel.characterName ?? "")"
        self.profileImage = posterBaseUrl + "w200" + (actorModel.profileImage ?? "some placehoder image")

    }
    
}
