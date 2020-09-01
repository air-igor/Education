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
    
    
    var coctailNetworkManager = CoctailNetworkManager()
    var coctailList = [Drinks]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        coctailSearchSearchBar.delegate = self


    }
    
}

extension SearchCoctailViewController: UITableViewDataSource, UITableViewDelegate  {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return coctailList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellSearch", for: indexPath)
        cell.textLabel?.text = coctailList[indexPath.row].strDrink
        tableView.reloadData()
          
          return cell
    }
    
    
}

extension SearchCoctailViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {

        let urlString = ApiSend.startUrl + ApiSend.devlopmentKey + "/search.php?s=\(searchText.replacingOccurrences(of: " ", with: "%20"))"
            guard let url = URL(string: urlString) else { return }
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { (data, response, error) in
                if let data = data {
                    self.parseJSON(withData: data)
                }
            }
            task.resume()
        }
    
    func parseJSON(withData data: Data) {
        let decoder = JSONDecoder()
        do {
            let coctailListData = try decoder.decode(CoctailListData.self, from: data)
            print(coctailListData.drinks)
    
        } catch let error as NSError {
            print(error.localizedDescription)
    }
    
   }
    
}
