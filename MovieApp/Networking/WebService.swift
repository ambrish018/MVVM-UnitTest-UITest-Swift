//
//  WebService.swift
//  MovieApp
//
//  Created by YASH COMPUTERS on 28/08/19.
//  Copyright © 2019 ambrish. All rights reserved.
//

import Foundation

//MARK:- MovieListProtocol
//Mark:- Popular Movie List Fetch
protocol PopularMovieDataFetcherProtocol {
    func fetchPopularMovies(page:Int16,completion: @escaping ([MovieModel]?,_ errorMessage: String?)->())
}
class PopularMovieDataFetcher: PopularMovieDataFetcherProtocol {
    func fetchPopularMovies(page:Int16,completion: @escaping ([MovieModel]?,_ errorMessage: String?)->())  {
        //https://api.themoviedb.org/3/movie/popular?api_key=<<api_key>>&language=en-US&page=1
        HttpClient.shared.GETRequest(endPoint: .PopularMovies, parameters: [APIRequestParameterKey.apiKey.rawValue:API_KEY,APIRequestParameterKey.language.rawValue:language,APIRequestParameterKey.page.rawValue:"\(page)"]) { (data, response, error) in
            do {
                guard let dataToParse = data else {
                    print("Something went wrong")
                    return
                }
                let decoder = JSONDecoder()
                do {
                let movieData = try decoder.decode(MovieData.self, from: dataToParse)
                    if movieData.result.isEmpty {
                        completion(movieData.result,"No Data Found")
                    }else{
                    completion(movieData.result,nil)
                    }
                    
                }catch {
                    print("couldn't decode with error \(error)")
                    completion([MovieModel](),"No Data Found")

                }
            }
            
        }
        
    
        
    }
}
//Mark:- NowPlaying Movie List Fetch
protocol NowplayingMovieDataFetcherProtocol{
    func fetchNowPlayingMovies(page:Int16,completion: @escaping ([MovieModel]?,_ errorMessage: String?)->())
}
class NowplayingMovieDataFetcher: NowplayingMovieDataFetcherProtocol {
    func fetchNowPlayingMovies(page:Int16,completion: @escaping ([MovieModel]?,_ errorMessage: String?)->())  {
        HttpClient.shared.GETRequest(endPoint: .NowPlayingMovies, parameters: [APIRequestParameterKey.apiKey.rawValue:API_KEY,APIRequestParameterKey.language.rawValue:language,APIRequestParameterKey.page.rawValue:"\(page)"]) { (data, response, error) in
            do {
                guard let dataToParse = data else {
                    print("Something went wrong")
                    return
                }
                let decoder = JSONDecoder()
                do {
                    let movieData = try decoder.decode(MovieData.self, from: dataToParse)
                    if movieData.result.isEmpty {
                        completion(movieData.result,"No Data Found")
                    }else{
                        completion(movieData.result,nil)
                    }
                    
                }catch {
                    print("couldn't decode with error \(error)")
                    completion([MovieModel](),"No Data Found")

                }
            }
            
        }
        
        
        
    }
}
//Mark:- GetToken
protocol TokenFetcherPrtocol {
  static  func fetchToken(completion:@escaping (_ token:String?,_ errorMessage: String?)->())
}
class TokenFetcher: TokenFetcherPrtocol {
   static func fetchToken(completion:@escaping (_ token :String?,_ errorMessage:String?) -> ())  {
        HttpClient.shared.GETRequest(endPoint: .GetToken, parameters: [APIRequestParameterKey.apiKey.rawValue:API_KEY]) { (data, response, error) in
            do {
                guard let dataToParse = data else {
                    print("Something went wrong")
                    return
                }
            if  let json = try JSONSerialization.jsonObject(with: dataToParse, options: .mutableContainers) as? [String:Any] {
                print(json)
                guard let success = json[APIResponseParameterKey.sucess.rawValue] as? Bool else {
                   // completion("","api failed with\()")
                    fatalError("something went wrong")
                }
                guard let token = json[APIResponseParameterKey.token.rawValue] as? String else {
                    print("token is not there")
                    fatalError("something went wrong")

                }
                if success {
                    if let expiryAt = json[APIResponseParameterKey.expiryAt.rawValue] as? String {
                    Util.saveExpiry(expiryUTC: expiryAt)
                    }
                    completion(token,nil)
                }else {
                    completion(json.debugDescription,"send Error")

                }
                //print(json)

                }
            } catch {
                print(error.localizedDescription)
            }
        }
    }
    
    
}

//Mark: MovieDetailDataFether
protocol MovieDeatilDataFetcherProtocol {
    func fetchMovieDetail(movieDetailUrlStr:String,completion: @escaping (MovieDetailModel?,_ errorMessage: String?)->())
    func fetchMovieCredits(movieDetailUrlStr:String,completion: @escaping (ActorData?,_ errorMessage: String?)->())
}
class MovieDeatilDataFetcher:MovieDeatilDataFetcherProtocol {
    ///movie/{movie_id}/credits
    func fetchMovieDetail(movieDetailUrlStr:String,completion: @escaping (MovieDetailModel?,_ errorMessage: String?)->()){
        
        HttpClient.shared.GETRequest(withUrl: movieDetailUrlStr, parameters: [APIRequestParameterKey.apiKey.rawValue:API_KEY]) { (data, response, err) in
            
            if err != nil {
                completion(nil,"some error")
            }else {
                let httpResponse = response as? HTTPURLResponse
                if httpResponse?.statusCode == 200 {
                    guard let dataToParse = data else {
                        completion(nil,"no data found")
                        return
                    }
                    let decoder = JSONDecoder()
                    do {
                        let movieData = try decoder.decode(MovieDetailModel.self, from: dataToParse)
                            completion(movieData,nil)
                        
                        
                    }catch {
                        print("couldn't decode with error \(error)")
                        completion(nil,"No Data Found")
                        
                    }
                    
                }
            }
        }
    }
    
    func fetchMovieCredits(movieDetailUrlStr:String,completion: @escaping (ActorData?,_ errorMessage: String?)->()){
        let creditUrl = movieDetailUrlStr + "/credits"
        HttpClient.shared.GETRequest(withUrl: creditUrl, parameters: [APIRequestParameterKey.apiKey.rawValue:API_KEY]) { (data, response, err) in
            
            if err != nil {
                completion(nil,"some error")
            }else {
                let httpResponse = response as? HTTPURLResponse
                if httpResponse?.statusCode == 200 {
                    guard let dataToParse = data else {
                        completion(nil,"no data found")
                        return
                    }
                    let decoder = JSONDecoder()
                    do {
                        let actorData = try decoder.decode(ActorData.self, from: dataToParse)
                        completion(actorData,nil)
                        
                        
                    }catch {
                        print("couldn't decode with error \(error)")
                        completion(nil,"No Data Found")
                        
                    }
                    
                }
            }
        }
    }
}
