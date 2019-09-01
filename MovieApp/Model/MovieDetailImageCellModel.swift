//
//  MovieDetailImageCellModel.swift
//  MovieApp
//
//  Created by YASH COMPUTERS on 31/08/19.
//  Copyright © 2019 ambrish. All rights reserved.
//

import Foundation
class MovieDetailImageCellModel   {
    
    
    // movie poster, movie title, and rating score (based on votes)
    let id : Int
    let moviePoster500 : String? //
    let movieTitle : String?
    let voteAverage : String?
    let runningTime : String?
    let releaseDate : String?
    let numberOfVotes : String?
    let ratingScore : String?
    var language : String = ""
    init(movieModel: MovieDetailModel) {
        self.id = movieModel.id
        self.movieTitle = movieModel.movieTitle
        self.voteAverage = "\(movieModel.voteAverage )"
        self.moviePoster500 = posterBaseUrl + "w500" + (movieModel.moviePoster ?? "some placehoder image")
        self.runningTime = "\(movieModel.runningTime)"
        self.releaseDate = movieModel.releaseDate
        self.numberOfVotes = "\(movieModel.numberOfVotes ?? 0)"
        self.ratingScore = "\(movieModel.ratingScore ?? 0.0)"
        if let langArr = movieModel.languages {
        for lang in langArr {
            if lang.id == movieModel.originalLanguage {
                self.language = lang.name ?? ""
                break
            }
        }
        }else{
            self.language = ""

        }
        
    }
        
}
/*
 Movie title
 Movie poster
 Running time
 Release date
 Rating score and number of votes
 */
class MovieDetailGenereCellModel   {
    
    let generes : String?
    let categoryLabelTitle : String?
    
    init(genereArray: [Genere]) {
        if genereArray.count == 0  {
            self.categoryLabelTitle = ""
        }else {
            self.categoryLabelTitle = "Category:"

        }
        
       self.generes =  genereArray.map { (genere) -> String in
            return genere.name ?? ""
        }.joined(separator: ",")
    }
    
    
    
}
