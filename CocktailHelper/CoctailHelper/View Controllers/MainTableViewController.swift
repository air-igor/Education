//
//  MainTableViewController.swift
//  CoctailHelper
//
//  Created by Игорь Попов on 29.08.2020.
//  Copyright © 2020 AirIgor. All rights reserved.
//

import UIKit

class MainTableViewController: UITableViewController {
    @IBOutlet weak var imageView: UIImageView!
    
    var coctailNetworkManager = CoctailNetworkManager()
    var coctailList = [Drinks]()
    var coctail: Drinks?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        coctailNetworkManager.fetchCoctailList(result: { [weak self] in
                self?.coctailList = $0.drinks
            DispatchQueue.main.async {
            self?.tableView.reloadData()
            }
            })
        }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {        return coctailList.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = coctailList[indexPath.row].strDrink
      
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "showDetails", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? DetailRandomViewController {
            destination.coctail = coctailList[tableView.indexPathForSelectedRow?.row ?? 1]
        }
    }
    
    @IBAction func closeAction(_ segue: UIStoryboardSegue) {}
    
}
