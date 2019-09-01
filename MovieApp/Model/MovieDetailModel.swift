//
//  MovieDetailModel.swift
//  MovieApp
//
//  Created by YASH COMPUTERS on 30/08/19.
//  Copyright © 2019 ambrish. All rights reserved.
//

import Foundation

//TO DO :- make equatable
class MovieDetailModel: Decodable {
    let id : Int
    let moviePoster : String?
    
    let movieTitle : String?
    let voteAverage : Float
    let runningTime : Int
    let releaseDate : String?
    let originalLanguage : String?
    let ratingScore : Float?
    let numberOfVotes : Int?
    let overview : String?
    let generes : [Genere]?
    let languages : [Language]?
    
    enum MovieDetailKeys : String,CodingKey {
        case id = "id"
        case moviePoster = "poster_path"
        case movieTitle = "title"
        case voteAverage = "vote_average"
        case runningTime = "runtime"
        case releaseDate = "release_date"
        case originalLanguage = "original_language"
        case ratingScore = "popularity"
        case numberOfVotes = "vote_count"
        case overview = "overview"
        case languages = "spoken_languages"
        case generes = "genres"
    }
    
    required init(from decoder: Decoder) throws {
        do {
        let container = try decoder.container(keyedBy: MovieDetailKeys.self)
            self.id = try container.decode(Int.self, forKey: .id)
            self.moviePoster = try container.decodeIfPresent(String.self, forKey:.moviePoster)
            self.movieTitle = try container.decodeIfPresent(String.self, forKey: .movieTitle)
            self.voteAverage = try container.decodeIfPresent(Float.self, forKey: .voteAverage) ?? 0
            
            self.runningTime = try container.decodeIfPresent(Int.self, forKey: .runningTime) ?? 0
            self.releaseDate = try container.decodeIfPresent(String.self, forKey: .releaseDate)
            self.originalLanguage = try container.decodeIfPresent(String.self, forKey: .originalLanguage)
            self.ratingScore = try container.decodeIfPresent(Float.self, forKey: .ratingScore)
            self.numberOfVotes = try container.decodeIfPresent(Int.self, forKey: .numberOfVotes)
            self.overview = try container.decodeIfPresent(String.self, forKey: .overview)
            
            var spokenLaguages = try container.nestedUnkeyedContainer(forKey: .languages)
            var languageTempArr = [Language]()
            while !spokenLaguages.isAtEnd {
                let lang = try spokenLaguages.decode(Language.self)
                languageTempArr.append(lang)
            }
            self.languages = languageTempArr
            
            
            var generes = try container.nestedUnkeyedContainer(forKey: .generes)
            var genreTempArr = [Genere]()
            while !generes.isAtEnd {
                let genereObj = try generes.decode(Genere.self)
                genreTempArr.append(genereObj)
            }
            self.generes = genreTempArr
            
        }catch {
            print("unable to decode movieDetail Model\(error)")
            throw error
        }
    }
    
}
class Genere : Decodable{
    let id : Int
    let name : String?
    enum GenereCodingKeys: String, CodingKey {
        case id = "id"
        case name = "name"
    }
    required init(from decoder: Decoder) throws {
        do {
            let container = try decoder.container(keyedBy: GenereCodingKeys.self)
            self.id = try container.decode(Int.self, forKey: .id)
            self.name = try container.decodeIfPresent(String.self, forKey: .name)
        }catch{
            print("unable to decode with \(error)")
            throw error
        }
    }
}
class Language : Decodable{

    let id : String?
    let name : String?
    enum LanguageCodingKeys: String, CodingKey {
        case id = "iso_639_1"
        case name = "name"
    }
    required init(from decoder: Decoder) throws {
        do {
            let container = try decoder.container(keyedBy: LanguageCodingKeys.self)
            self.id = try container.decodeIfPresent(String.self, forKey: .id)
            self.name = try container.decodeIfPresent(String.self, forKey: .name)
        }catch{
            print("unable to decode with \(error)")
            throw error
        }
    }
}

class ActorData : Decodable{
    let id :Int
    let casts : [Actor]?
    enum CodindKeys: String,CodingKey {
        case id = "id"
        case casts = "cast"
    }
    required init(from decoder: Decoder) throws {
        do {
           let container =  try decoder.container(keyedBy: CodindKeys.self)
            self.id = try container.decode(Int.self, forKey: .id)
            var castsContainer = try container.nestedUnkeyedContainer(forKey: .casts)
            var tempActorArr = [Actor]()
            while !castsContainer.isAtEnd {
                let actor = try castsContainer.decode(Actor.self)
                tempActorArr.append(actor)
            }
            self.casts = tempActorArr
            
        } catch  {
            print("unable to decode actors with \(error)")
            throw error

        }
    }
}
class Actor : Decodable {
    let id : Int
    let profileImage : String?
    let characterName : String?
    let name : String?
    enum ActorCodingKeys:String,CodingKey {
        case id = "cast_id"
        case profileImage = "profile_path"
        case characterName = "character"
        case name = "name"
    }
    required init(from decoder: Decoder) throws {
        do {
            let container =  try decoder.container(keyedBy: ActorCodingKeys.self)
            self.id = try container.decode(Int.self, forKey: .id)
            self.profileImage = try container.decodeIfPresent(String.self, forKey: .profileImage)
            self.characterName = try container.decodeIfPresent(String.self, forKey: .characterName)
            self.name = try container.decodeIfPresent(String.self, forKey: .name)

        }catch {
            print("unable to decode actor with \(error)")
            throw error

        }
    }
    
}

/*
 
 Movie title
 Movie poster
 Running time
 Release date
 Rating score and number of votes
 Synopsis
 Original Languages
 Genres
 List of actor/actress (limit to 5 people) including the role name
 

 //
 detail
 {
 "adult": false,
 "backdrop_path": "/fCayJrkfRaCRCTh8GqN30f8oyQF.jpg",
 "belongs_to_collection": null,
 "budget": 63000000,
 "genres": [
 {
 "id": 18,
 "name": "Drama"
 }
 ],
 "homepage": "",
 "id": 550,
 "imdb_id": "tt0137523",
 "original_language": "en",
 "original_title": "Fight Club",
 "overview": "A ticking-time-bomb insomniac and a slippery soap salesman channel primal male aggression into a shocking new form of therapy. Their concept catches on, with underground \"fight clubs\" forming in every town, until an eccentric gets in the way and ignites an out-of-control spiral toward oblivion.",
 "popularity": 0.5,
 "poster_path": null,
 "production_companies": [
 {
 "id": 508,
 "logo_path": "/7PzJdsLGlR7oW4J0J5Xcd0pHGRg.png",
 "name": "Regency Enterprises",
 "origin_country": "US"
 },
 {
 "id": 711,
 "logo_path": null,
 "name": "Fox 2000 Pictures",
 "origin_country": ""
 },
 {
 "id": 20555,
 "logo_path": null,
 "name": "Taurus Film",
 "origin_country": ""
 },
 {
 "id": 54050,
 "logo_path": null,
 "name": "Linson Films",
 "origin_country": ""
 },
 {
 "id": 54051,
 "logo_path": null,
 "name": "Atman Entertainment",
 "origin_country": ""
 },
 {
 "id": 54052,
 "logo_path": null,
 "name": "Knickerbocker Films",
 "origin_country": ""
 },
 {
 "id": 25,
 "logo_path": "/qZCc1lty5FzX30aOCVRBLzaVmcp.png",
 "name": "20th Century Fox",
 "origin_country": "US"
 }
 ],
 "production_countries": [
 {
 "iso_3166_1": "US",
 "name": "United States of America"
 }
 ],
 "release_date": "1999-10-12",
 "revenue": 100853753,
 "runtime": 139,
 "spoken_languages": [
 {
 "iso_639_1": "en",
 "name": "English"
 }
 ],
 "status": "Released",
 "tagline": "How much can you know about yourself if you've never been in a fight?",
 "title": "Fight Club",
 "video": false,
 "vote_average": 7.8,
 "vote_count": 3439
 }
 
 ///credits
 
 {
 "id": 550,
 "cast": [
 {
 "cast_id": 4,
 "character": "The Narrator",
 "credit_id": "52fe4250c3a36847f80149f3",
 "gender": 2,
 "id": 819,
 "name": "Edward Norton",
 "order": 0,
 "profile_path": "/eIkFHNlfretLS1spAcIoihKUS62.jpg"
 },
 {
 "cast_id": 5,
 "character": "Tyler Durden",
 "credit_id": "52fe4250c3a36847f80149f7",
 "gender": 2,
 "id": 287,
 "name": "Brad Pitt",
 "order": 1,
 "profile_path": "/kc3M04QQAuZ9woUvH3Ju5T7ZqG5.jpg"
 },
 */
