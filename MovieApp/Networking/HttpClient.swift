//
//  HttpClient.swift
//  MovieApp
//
//  Created by YASH COMPUTERS on 27/08/19.
//  Copyright © 2019 ambrish. All rights reserved.
//

import Foundation

let baseUrl = "https://api.themoviedb.org/3/"
let  API_KEY = "cbe09d78729b9b5469a02812392e13f8"
let language = "en-US"
let posterBaseUrl = "https://image.tmdb.org/t/p/"

protocol URLSessionProtocol {
    typealias completionHandler = (Data?, URLResponse?, Error?) -> Void

func dataTask(with request: URLRequest, completionHandler: @escaping completionHandler) -> URLSessionDataTask
    
}
extension URLSession : URLSessionProtocol{}

class HttpClient {
    static let shared : HttpClient = {
        let session = URLSession(configuration: .default)

        return HttpClient(session: session)
    }()
    private let session : URLSessionProtocol

    init(session : URLSessionProtocol = URLSession.shared) {
        self.session = session
    }
    func GETRequest( endPoint:API,parameters: [String:String?], completionHandler:@escaping (Data?,URLResponse,Error?)->Void) {
        
        guard let url = URL(string: endPoint.url) else {
            fatalError("bad url")
        }
        guard var urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: false) else{
            fatalError("bad url")
        }
        var querryItems = [URLQueryItem]()
        for (key,value) in parameters{
            if let val = value  {
            let item = URLQueryItem(name: key, value: val)
            querryItems.append(item)
            }
        }
        urlComponents.queryItems = querryItems
        var urlRequest = URLRequest(url:urlComponents.url!)
        urlRequest.httpMethod = "GET"
        let task =  self.session.dataTask(with: urlRequest) { (data, response, error) in
            
            completionHandler(data,response!,error)
            
        }
        task.resume()
    }
    func GETRequest(withUrl urlStr:String,parameters: [String:String?], completionHandler:@escaping (Data?,URLResponse,Error?)->Void) {
        
        guard let url = URL(string: urlStr) else {
            fatalError("bad url")
        }
        guard var urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: false) else{
            fatalError("bad url")
        }
        var querryItems = [URLQueryItem]()
        for (key,value) in parameters{
            if let val = value  {
                let item = URLQueryItem(name: key, value: val)
                querryItems.append(item)
            }
        }
        urlComponents.queryItems = querryItems
        var urlRequest = URLRequest(url:urlComponents.url!)
        urlRequest.httpMethod = "GET"
        let task =  self.session.dataTask(with: urlRequest) { (data, response, error) in
            
            completionHandler(data,response!,error)
            
        }
        task.resume()
    }
   
}


enum API : String {
    case GetToken = "authentication/token/new"
    case PopularMovies = "movie/popular"
    case NowPlayingMovies = "movie/now_playing"
    case GetMoviesDetail = "movie/"
    case SomeCase = "xxxx"

    
    var url : String {
        switch self {
        case .SomeCase:
            print("somecase for different base url")
            return self.rawValue
        default:
            let url = baseUrl + self.rawValue
            return url
        }
    }
}

enum APIRequestParameterKey : String {
    case apiKey = "api_key"
    case language = "en-US"
    case page = "page"
}
enum APIResponseParameterKey : String {
    case token = "request_token"
    case sucess = "success"
    case expiryAt = "expires_at"
}
