//
//  SearchCoctailViewController.swift
//  CoctailHelper
//
//  Created by Игорь Попов on 31.08.2020.
//  Copyright © 2020 AirIgor. All rights reserved.
//

import UIKit

class SearchCoctailViewController: UIViewController {
    @IBOutlet weak var coctailSearchSearchBar: UISearchBar!
    @IBOutlet weak var coctailSearchTableView: UITableView!
    
//    private var timer: Timer?
    
    var coctailNetworkManager = CoctailNetworkManager()
    var coctailList = [Drinks]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        coctailSearchTableView.delegate = self
        coctailSearchTableView.dataSource = self
        coctailSearchSearchBar.delegate = self


    }
    
    func searchList(searchText: String, result: @escaping ((CoctailListData) -> Void)) {
            let urlString = ApiSend.startUrl + ApiSend.devlopmentKey + "/search.php?s=\(searchText.replacingOccurrences(of: " ", with: "%20"))"
                guard let url = URL(string: urlString) else { return }
                let session = URLSession(configuration: .default)
                let task = session.dataTask(with: url) { (data, response, error) in
                    if let data = data {
                        let decoder = JSONDecoder()
                            do {
                                let coctailListData = try decoder.decode(CoctailListData.self, from: data)
                               result(coctailListData)
                            } catch let error as NSError {
                                print(error.localizedDescription)
                        }
                    }
                }
                task.resume()
            }
    }
        

extension SearchCoctailViewController: UITableViewDataSource, UITableViewDelegate  {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return coctailList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCell(withIdentifier: "cellSearch", for: indexPath)
        cell.textLabel?.text = coctailList[indexPath.row].strDrink
          
          return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "showMore", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "showMore") {
//            var viewController = segue.destinationViewController as! SearchCoctailViewController
//            viewController.passedValue =
//
        }
    }
    
}
    

extension SearchCoctailViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        searchList(searchText: searchText) { [weak self] (data) in
            DispatchQueue.main.async {
                self?.coctailList = data.drinks
            self?.coctailSearchTableView.reloadData()
                
            }
        }
    }
}
