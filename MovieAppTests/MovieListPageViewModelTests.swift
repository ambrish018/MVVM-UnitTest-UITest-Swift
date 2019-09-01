//
//  MovieListPageViewModelTests.swift
//  MovieAppTests
//
//  Created by YASH COMPUTERS on 30/08/19.
//  Copyright © 2019 ambrish. All rights reserved.
//

import XCTest

class MovieListPageViewModelTests: XCTestCase {
    var viewModelSut : MoviePopularPageViewModel!
    var popularDataFetcher : MockPopularMovieFether!
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        viewModelSut = MoviePopularPageViewModel(dataFetcher: MockPopularMovieFether())
        viewModelSut.viewDidLoad()
        popularDataFetcher = MockPopularMovieFether()
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        viewModelSut = nil
        popularDataFetcher = nil
    }
    func testOutPut(){
        XCTAssertEqual(viewModelSut.numberOfRows, popularDataFetcher.tableViewDataModel.count)
    }
    func testDatamodelForIndexPath(){
        let indexPath1 = IndexPath(row: 0, section: 1)
        XCTAssertEqual(viewModelSut.tableCellDataModelForIndexPath(indexPath1), popularDataFetcher.tableViewDataModel[0])
        let indexPath2 = IndexPath(row: 1, section: 1)
        XCTAssertEqual(viewModelSut.tableCellDataModelForIndexPath(indexPath2), popularDataFetcher.tableViewDataModel[1])
    }
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
class MockPopularMovieFether: PopularMovieDataFetcherProtocol {
    var movies : [MovieModel]!
    var tableViewDataModel =  [MovieCellDataModel]()
    
    init() {
        let movieJsonData = Data("""
[
{
 "poster_path": "/e1mjopzAS2KNsvpbpahQ1a6SkSn.jpg",
 "id": 297761,
 "original_title": "Suicide Squad",
 "title": "Suicide Squad",
 "vote_average": 5.91
 },
{
 "poster_path": "/e1mjopzAS2KNKJKJWWwkdwkdwKW.jpg",
 "id": 297761,
 "original_title": "My Squad",
 "title": "MY Squad",
 "vote_average": 7.91
 }
]
""".utf8)
        
        let decoder = JSONDecoder()
        movies = try! decoder.decode([MovieModel].self, from: movieJsonData)
        for movie in movies {
            tableViewDataModel.append(MovieCellDataModel(movieModel: movie))
        }
    }
    func fetchPopularMovies(page: Int16, completion: @escaping ([MovieModel]?, String?) -> ()) {
        completion(movies,nil)
    }
    
}
