//
//  MovieModelTest.swift
//  MovieAppTests
//
//  Created by YASH COMPUTERS on 30/08/19.
//  Copyright © 2019 ambrish. All rights reserved.
//

import XCTest

class MovieModelTest: XCTestCase {
    private let movieJsonData = Data("""
{
 "poster_path": "/e1mjopzAS2KNsvpbpahQ1a6SkSn.jpg",
 "id": 297761,
 "original_title": "Suicide Squad",
 "title": "Suicide Squad",
 "vote_average": 5.91
 }
""".utf8)
    
    var sut : MovieCellDataModel!
    var movie : MovieModel!
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        let decoder = JSONDecoder()
        self.movie = try! decoder.decode(MovieModel.self, from: movieJsonData)
        self.sut = MovieCellDataModel(movieModel: movie)
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        sut = nil
        movie = nil
    }
    func testMovoleCellDataMOdel(){
        //Not Nil
        XCTAssertNotNil(sut.id)
        XCTAssertNotNil(sut.movieTitle)
        XCTAssertNotNil(sut.moviePoster200)
        XCTAssertNotNil(sut.voteAverage)
        //equal
        XCTAssertEqual(sut.movieTitle, movie.movieTitle)
        XCTAssertEqual(sut.id, movie.id)
        XCTAssertEqual(sut.voteAverage, "\(movie.voteAverage)")
        XCTAssertEqual(sut.moviePoster200!,self.getFullPosterPath())

    }
    func getFullPosterPath()->String{
        return posterBaseUrl + "w200" + (movie.moviePoster ?? "")
    }
    func testMovieModel() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        let decoder = JSONDecoder()
        let movieModel = try! decoder.decode(MovieModel.self, from: movieJsonData)
        XCTAssertEqual(movieModel.moviePoster, "/e1mjopzAS2KNsvpbpahQ1a6SkSn.jpg")
        XCTAssertEqual(movieModel.id,297761)
        XCTAssertEqual(movieModel.movieTitle, "Suicide Squad")
        XCTAssertEqual(movieModel.voteAverage, 5.91)
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
