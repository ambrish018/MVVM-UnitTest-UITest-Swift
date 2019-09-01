//
//  MovieDetailViewModel.swift
//  MovieApp
//
//  Created by YASH COMPUTERS on 30/08/19.
//  Copyright © 2019 ambrish. All rights reserved.
//

import Foundation
import NotificationBannerSwift
class MovieDetailViewModel {
    //OutPut
    var numberOfRows = 0
    var errorMessage = ""
    var titleText = ""
    //input
    var movieDetailFetcher : MovieDeatilDataFetcherProtocol!
    
    var viewDidload : (String)->() = {_ in }
    var callBack : ()->() = {}
    private let staticNumberOfCellCount = 3
    private var dataModel : MovieDetailModel!
    private var dataActorModelArray : [Actor] = [Actor]()
    init(movieDetailDataFetcher:MovieDeatilDataFetcherProtocol) {
        self.movieDetailFetcher = movieDetailDataFetcher
        self.viewDidload = { [weak self](urlStr) in
            self?.fetchData(urlStr)
        }
    }
   private func fetchData(_ urlString: String)  {
    let operationQueue = OperationQueue()

    let operation1 = BlockOperation(){
        let group = DispatchGroup()

        group.enter()
        self.movieDetailFetcher.fetchMovieDetail(movieDetailUrlStr: urlString) { [weak self](movieDetail, errorString) in
            //TO DO
            if errorString == nil{
            self?.dataModel = movieDetail
            }else {
               self?.showError()
            }
            group.leave()

        }
        
        group.enter()
        self.movieDetailFetcher.fetchMovieCredits(movieDetailUrlStr: urlString) {[weak self] (actorData, errorString) in
            if errorString == nil{
                self?.dataActorModelArray = actorData?.casts ?? [Actor]()
            }else{
                self?.showError()
            }
            group.leave()

            
        }
        group.wait()

    }

    let operation2 = BlockOperation(){
        self.configureOutput()
        self.callBack()
        }
    
    operation2.addDependency(operation1)
    
    operationQueue.addOperation(operation1)
    operationQueue.addOperation(operation2)
    }
    // configure output
   private func configureOutput(){
    let actorCount = (self.dataActorModelArray.count > 5) ? 5 :  self.dataActorModelArray.count
    numberOfRows = staticNumberOfCellCount + actorCount
    self.titleText = self.dataModel?.movieTitle ?? ""

    }
    
    
    //MARK:- ImageCell
    func getImageCellDataModel()-> MovieDetailImageCellModel{
        return MovieDetailImageCellModel(movieModel: self.dataModel)
    }
    //Mark:- Overview
    func getOverviewText()-> String {
        return self.dataModel.overview ?? ""
    }
    func getGeneres() -> MovieDetailGenereCellModel {
        return MovieDetailGenereCellModel(genereArray: self.dataModel.generes ?? [])
    }
    func getActorCellMdeolFor(indexPath:IndexPath)->ActorCellModel{
        let index = indexPath.row - staticNumberOfCellCount 
        return ActorCellModel(actorModel: self.dataActorModelArray[index])
    }
    
}
extension MovieDetailViewModel {
    func showError() {
        let banner = StatusBarNotificationBanner(title: "Error in Finding Details", style: .danger)
        banner.show()
    }
}
