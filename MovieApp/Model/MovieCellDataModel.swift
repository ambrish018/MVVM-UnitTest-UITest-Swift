//
//  MovieCellDataModel.swift
//  MovieApp
//
//  Created by YASH COMPUTERS on 29/08/19.
//  Copyright © 2019 ambrish. All rights reserved.
//

import Foundation
class MovieCellDataModel : Equatable {
    static func == (lhs: MovieCellDataModel, rhs: MovieCellDataModel) -> Bool {
        return (lhs.id == rhs.id) && (lhs.movieTitle == rhs.movieTitle) && (lhs.moviePoster200 == rhs.moviePoster200) && (lhs.voteAverage == rhs.voteAverage)
    }
    
    // movie poster, movie title, and rating score (based on votes)
    let id : Int
    let moviePoster200 : String? //
    let movieTitle : String?
    let voteAverage : String?
    let movieDetailUrl : String

    init(movieModel: MovieModel) {
        self.id = movieModel.id
        self.movieTitle = movieModel.movieTitle
        self.voteAverage = "\(movieModel.voteAverage )"
        self.moviePoster200 = posterBaseUrl + "w200" + (movieModel.moviePoster ?? "some placehoder image")
        //self.getFullImagePath(posterPath: , withbaseUrl: posterBaseUrl, and: "w200")
        self.movieDetailUrl =  movieModel.movieDetailUrl//"\(API.GetMoviesDetail.url)\(self.id)"

    }
    func getFullImagePath(posterPath:String,withbaseUrl baseurl:String, and widthParameter: String)->String{
        //w200
        
        return posterBaseUrl + "w200" +  posterPath
        //"return ""
    }
}
