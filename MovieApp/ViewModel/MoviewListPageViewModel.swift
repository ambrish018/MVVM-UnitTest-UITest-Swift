//
//  File.swift
//  MovieApp
//
//  Created by YASH COMPUTERS on 29/08/19.
//  Copyright © 2019 ambrish. All rights reserved.
//

import Foundation

protocol MovieListProtocol {
    var dataFetcher: PopularMovieDataFetcherProtocol! {get set}
    var dataFetcherNowPlaying: NowplayingMovieDataFetcherProtocol! {get set}
    var numberOfRows : Int {get set}
    var viewDidLoad: () -> () {get set}
    var callBack: () -> ()  {get set}
     var tableDataSource : [MovieCellDataModel] {get set}
    var page : Int16 {get set}
    func tableCellDataModelForIndexPath(_ indexPath: IndexPath) -> MovieCellDataModel
}

class MoviePopularPageViewModel : MovieListProtocol  {
    var dataFetcherNowPlaying: NowplayingMovieDataFetcherProtocol! // kept it for now //TODO
    
    
    var dataFetcher: PopularMovieDataFetcherProtocol!

    
    var numberOfRows = 0
    var errorMessage = ""
    
    var viewDidLoad: () -> () = { }
    var callBack: () -> () = {}
     var tableDataSource = [MovieCellDataModel]()
     var page : Int16 = 1
    private var dataModel: [MovieModel]! {
        didSet {
            configureTableDataSource()
            configureOutput()
            self.callBack()

        }
    }
    
    init(dataFetcher: PopularMovieDataFetcherProtocol) {
        self.dataFetcher = dataFetcher
        viewDidLoad = { [weak self] in
            self?.page+=1
            self?.getPlacesData(page: self?.page ?? 1)
        }
    }
    
    
    private func getPlacesData(page:Int16) {
        if page > 1000  {
            self.errorMessage = "max Page limit"

            return
        }
        dataFetcher.fetchPopularMovies(page: page) { [weak self](movieList, errorString) in
            guard let movies = movieList else {
                self?.errorMessage = errorString!
                return
            }
            self?.dataModel = movies
            
        }
    }
    
    private func configureTableDataSource() {
        for movie in dataModel {
            tableDataSource.append(MovieCellDataModel(movieModel: movie))
        }
    }
    
    private func configureOutput() {
        numberOfRows = tableDataSource.count
    }
    
    func tableCellDataModelForIndexPath(_ indexPath: IndexPath) -> MovieCellDataModel {
        return tableDataSource[indexPath.row]
    }
}


// MARK:- Now Playing
class MovieNowPlayingPageViewModel : MovieListProtocol{
    
    var dataFetcher: PopularMovieDataFetcherProtocol! // keep it for consistency // TODO
    
    
    var dataFetcherNowPlaying: NowplayingMovieDataFetcherProtocol!
    
    
    var numberOfRows = 0
    var errorMessage = ""
    
    var viewDidLoad: () -> () = { }
    var callBack: () -> () = {}
     var tableDataSource = [MovieCellDataModel]()
     var page : Int16 = 1
    private var dataModel: [MovieModel]! {
        didSet {
            configureTableDataSource()
            configureOutput()
            self.callBack()
            
        }
    }
    
    init(dataFetcher: NowplayingMovieDataFetcherProtocol) {
        self.dataFetcherNowPlaying = dataFetcher
        viewDidLoad = { [weak self] in
            self?.page+=1
            self?.getPlacesData(page: self?.page ?? 1)
        }
    }
    
    private func getPlacesData(page:Int16) {
        if page > 1000 {
            self.errorMessage = "max Page limit"
            
            return
        }
        dataFetcherNowPlaying.fetchNowPlayingMovies(page: page) { [weak self](movieList, errorString) in
            guard let movies = movieList else {
                self?.errorMessage = errorString!
                return
            }
            self?.dataModel = movies
            
        }
        //        dataFetcher.fetchPlaces { [weak self] (placeList, errorMessage) in
        //            guard let places = placeList else {
        //                self?.displayError(errorMessage!)
        //                return
        //            }
        //            self?.dataModel = places
        //        }
    }
    
    private func configureTableDataSource() {
        for movie in dataModel {
            tableDataSource.append(MovieCellDataModel(movieModel: movie))
        }
    }
    
    private func configureOutput() {
        numberOfRows = tableDataSource.count
    }
    
    func tableCellDataModelForIndexPath(_ indexPath: IndexPath) -> MovieCellDataModel {
        return tableDataSource[indexPath.row]
    }
}
