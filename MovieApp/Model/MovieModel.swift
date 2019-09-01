//
//  MovieModel.swift
//  MovieApp
//
//  Created by YASH COMPUTERS on 28/08/19.
//  Copyright © 2019 ambrish. All rights reserved.
//
/*
 {
 "page": 1,
 "results": [
 {
 "poster_path": "/e1mjopzAS2KNsvpbpahQ1a6SkSn.jpg",
 "adult": false,
 "overview": "From DC Comics comes the Suicide Squad, an antihero team of incarcerated supervillains who act as deniable assets for the United States government, undertaking high-risk black ops missions in exchange for commuted prison sentences.",
 "release_date": "2016-08-03",
 "genre_ids": [
 14,
 28,
 80
 ],
 "id": 297761,
 "original_title": "Suicide Squad",
 "original_language": "en",
 "title": "Suicide Squad",
 "backdrop_path": "/ndlQ2Cuc3cjTL7lTynw6I4boP4S.jpg",
 "popularity": 48.261451,
 "vote_count": 1466,
 "video": false,
 "vote_average": 5.91
 },
 
 Running time
 Genres
 List of actor/actress (limit to 5 people) including the role name

 */
import Foundation
class MovieData: Decodable {
    var totalPages = 0
    var result : [MovieModel]
    enum CodingKeys: String, CodingKey {
        case totalPages = "total_pages"
        case result = "results"
    }
    required init(from decoder: Decoder) throws {

        do {
            let container = try decoder.container(keyedBy: CodingKeys.self)

            self.totalPages = try container.decode(Int.self, forKey: .totalPages)
            var movies = try container.nestedUnkeyedContainer(forKey: .result)
            var tempArr = [MovieModel]()
            while !movies.isAtEnd {
                do{
                let movie = try movies.decode(MovieModel.self)
                    tempArr.append(movie)
                }catch {
                    throw error
                }
            }
            self.result = tempArr
            
        }catch {
            print("error in decoing in movieData \(error)")
            throw error
        }
    }
}
class MovieModel:Decodable {
    // movie poster, movie title, and rating score (based on votes)

    let id : Int
    let moviePoster : String?
    let movieTitle : String?
    let voteAverage : Float
    let movieDetailUrl : String
    
    enum MovieCodingKeys:String, CodingKey {
        case id = "id"
        case moviePoster = "poster_path"
        case movieTitle = "title"
        case voteAverage = "vote_average"
        
    }
    
    required init(from decoder: Decoder) throws {
        do {
            let container = try decoder.container(keyedBy: MovieCodingKeys.self)
            self.id = try container.decode(Int.self, forKey: .id)
            self.moviePoster = try container.decodeIfPresent(String.self, forKey:.moviePoster)
            self.movieTitle = try container.decodeIfPresent(String.self, forKey: .movieTitle)
            self.voteAverage = try container.decodeIfPresent(Float.self, forKey: .voteAverage) ?? 0
            
            self.movieDetailUrl =  "\(API.GetMoviesDetail.url)\(self.id)"

        }catch {
            print(error)
            throw error
            //
        }
    }
    
}
