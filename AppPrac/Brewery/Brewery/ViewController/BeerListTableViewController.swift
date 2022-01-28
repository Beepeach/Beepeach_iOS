//
//  BeerListTableViewController.swift
//  Brewery
//
//  Created by JunHeeJo on 11/29/21.
//

import UIKit

class BeerListTableViewController: UITableViewController {
    // MARK: Properties
    var beerList = [Beer]()
    var dataTasks = [URLSessionTask]()
    var currentPage = 1
    
    // MARK: ViewLifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // UINavigationBar
        title = "Brewery"
        navigationController?.navigationBar.prefersLargeTitles = true
        
        // UITableView
        tableView.register(BeerListTableViewCell.self, forCellReuseIdentifier: "BeerListTableViewCell")
        tableView.rowHeight = 150
        
        tableView.prefetchDataSource = self
        fetchBeer(of: currentPage)
    }
    
    // MARK: - UITableViewDatasource
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return beerList.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        print("Rows: \(indexPath.row)")
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "BeerListTableViewCell", for: indexPath) as? BeerListTableViewCell else {
            return UITableViewCell()
        }
        
        let beer = beerList[indexPath.row]
        cell.configure(with: beer)
        
        return cell
    }
    
    
    // MARK: - UITableViewDelegate
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedBeer = beerList[indexPath.row]
        let detailVC = BeerDetailTableViewController()
        detailVC.beer = selectedBeer
        self.navigationController?.pushViewController(detailVC, animated: true)
    }
}


// MARK: - UITableViewDataSourcePrefetching
extension BeerListTableViewController: UITableViewDataSourcePrefetching {
    func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
        guard currentPage != 1 else { return }
        
        indexPaths.forEach {
            if ($0.row + 1) / 25 + 1 == currentPage {
                self.fetchBeer(of: currentPage)
            }
        }
    }
}


// MARK: - BeerListTableViewController + fetchBeer
private extension BeerListTableViewController {
    func fetchBeer(of page: Int) {
        guard let url = URL(string: "https://api.punkapi.com/v2/beers?page=\(page)"),
        dataTasks.firstIndex(where: { task in
            task.originalRequest?.url == url
        }) == nil
        else {
            return
        }
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        let dataTask = URLSession.shared.dataTask(with: request) { [weak self] data, response, error in
            guard error == nil,
                  let self = self,
                  let response = response as? HTTPURLResponse,
                  let data = data,
                  let beers = try? JSONDecoder().decode([Beer].self, from: data) else {
                      print("ERROR: \(error?.localizedDescription ?? "")")
                      return
                  }
            switch response.statusCode {
            case (200...299):
                self.beerList += beers
                self.currentPage += 1
                
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            case (400...499):
                print("""
                    ERROR: ClientError \(response.statusCode)
                """)
            case (500...599):
                print("""
                    ERROR: ServerError \(response.statusCode)
                """)
            default:
                print("""
                    ERROR: Error \(response.statusCode)
                """)
            }
        }
        dataTask.resume()
        dataTasks.append(dataTask)
    }
}
