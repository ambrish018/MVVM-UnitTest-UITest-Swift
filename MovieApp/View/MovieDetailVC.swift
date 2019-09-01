//
//  MovieDetailVC.swift
//  MovieApp
//
//  Created by YASH COMPUTERS on 30/08/19.
//  Copyright © 2019 ambrish. All rights reserved.
//

import UIKit

class MovieDetailVC: UIViewController {
   

    var detailUrl = ""
    var viewModel = MovieDetailViewModel(movieDetailDataFetcher: MovieDeatilDataFetcher())
    
    
    @IBOutlet weak var detailTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.viewDidload(detailUrl)
        viewModel.callBack = { [weak self] in
            DispatchQueue.main.async {
                self?.navigationItem.title = self?.viewModel.titleText
                self?.detailTableView.reloadData()
                
            }
        }
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
extension MovieDetailVC : UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.viewModel.numberOfRows
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case 0:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "cellPosterID", for: indexPath) as? MovieDetailImageCell else {
                fatalError()
            }
            
            let model = self.viewModel.getImageCellDataModel()
            cell.configureCell(model: model)
            
            return cell
            
        case 1:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "cellId", for: indexPath) as? MovieDetailOverviewTableViewCell else {
                fatalError()
                
            }
            cell.configureCell(overview: self.viewModel.getOverviewText())
            return cell

        case 2:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "cellGenereId", for: indexPath) as? MovieDetailGenresTableViewCell else {
                fatalError()
            }
            cell.configureCell(model: self.viewModel.getGeneres())
            return cell

        default:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "cellActorId", for: indexPath) as? ActorTableCell else {
                fatalError()
            }
            cell.configure(actorModel: viewModel.getActorCellMdeolFor(indexPath: indexPath))
            return cell
                //return UITableViewCell()
        }
       
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {

        switch indexPath.row {
        case 0:
            return 600//UITableView.automaticDimension
        case 1:
            return UITableView.automaticDimension
        case 2:
            return UITableView.automaticDimension
        default:
            return 44
        }
    }
    
    
}
