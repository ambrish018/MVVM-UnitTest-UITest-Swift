//
//  MovieListPageVC.swift
//  MovieApp
//
//  Created by YASH COMPUTERS on 29/08/19.
//  Copyright © 2019 ambrish. All rights reserved.
//

import UIKit

class MovieListPageVC: UIViewController {
    @IBOutlet weak var movieTableView: UITableView!
    enum MovieListType {
        case popular
        case nowPlaying
    }
    var viewModel : MovieListProtocol!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.viewDidLoad()
        // Do any additional setup after loading the view.
        viewModel.callBack = { [weak self] in
            DispatchQueue.main.async {
                self?.movieTableView.reloadData()

            }
        }
    }
    

   

}
extension MovieListPageVC : UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.viewModel.numberOfRows
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? MovieListTableViewCell else {
            fatalError()
        }
        if viewModel.numberOfRows == indexPath.row + 1 {
            self.callNextPage()
        }
       let model = self.viewModel.tableCellDataModelForIndexPath(indexPath)
        cell.configureCell(model: model)
        return cell
    }
    func callNextPage(){
        viewModel.viewDidLoad()
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 300
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let model = self.viewModel.tableCellDataModelForIndexPath(indexPath)
        let detailVC = self.storyboard?.instantiateViewController(withIdentifier: "MovieDetailVC") as! MovieDetailVC
        detailVC.detailUrl = model.movieDetailUrl
        self.navigationController?.pushViewController(detailVC, animated: true)
    }
    
}
extension MovieListPageVC {
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
}
