//
//  ViewController.swift
//  MovieApp
//
//  Created by YASH COMPUTERS on 25/08/19.
//  Copyright © 2019 ambrish. All rights reserved.
//

import UIKit
import CarbonKit
class MovieListVC: UIViewController {
   private var vcArray = [MovieListPageVC]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
       self.setUpSwipeNavigation()
        self.navigationItem.title = "Movies"
        
    }

    //MARK:- set up swipe navigation
    func setUpSwipeNavigation() {
        let nowPlayingVC = self.storyboard?.instantiateViewController(withIdentifier: "MovieListPageVC") as! MovieListPageVC
        nowPlayingVC.viewModel = MoviePopularPageViewModel(dataFetcher: PopularMovieDataFetcher())
        
        let popularVC = self.storyboard?.instantiateViewController(withIdentifier: "MovieListPageVC") as! MovieListPageVC
        popularVC.viewModel = MovieNowPlayingPageViewModel(dataFetcher: NowplayingMovieDataFetcher())
        
        vcArray = [nowPlayingVC,popularVC];
        let items = ["Now Playing", "Popular"]
        
        let carbonTabSwipeNavigation = CarbonTabSwipeNavigation(items: items, delegate: self)
        carbonTabSwipeNavigation.insert(intoRootViewController: self)
        carbonTabSwipeNavigation.setSelectedColor(UIColor.white)
        carbonTabSwipeNavigation.setNormalColor(UIColor.white)
        carbonTabSwipeNavigation.setIndicatorColor(UIColor.white)
        let eachWidth = UIScreen.main.bounds.width/2 - 100
        carbonTabSwipeNavigation.setTabExtraWidth(eachWidth)
        carbonTabSwipeNavigation.carbonTabSwipeScrollView.backgroundColor = UIColor.red
        // or carbonTabSwipeNavigation.insertIntoRootViewController(self, andTargetView: yourView)

    }
    
    @IBAction func SearchTapped(_ sender: Any) {
        //TODO
        Util.showUnderdevelopment()
    }
    
}
extension MovieListVC : CarbonTabSwipeNavigationDelegate {
    func carbonTabSwipeNavigation(_ carbonTabSwipeNavigation: CarbonTabSwipeNavigation, viewControllerAt index: UInt) -> UIViewController {
        // return viewController at index
        return vcArray[Int(index)]
    }
}


extension MovieListVC {
    
}
