//
//  FavoritesViewController.swift
//  D2.Heroes
//
//  Created by Игорь Попов on 19.11.2020.
//  Copyright © 2020 AirIgor. All rights reserved.
//

import UIKit
import RealmSwift

class FavoritesViewController: UITableViewController {
    
    let results = realm.objects(HeroEntry.self)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        view.backgroundColor = .white
    }
    
    private func setupTableView() {
    tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cellId")
        tableView.tableFooterView = UIView()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print(results.count)
        return results.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellId", for: indexPath)
        let heroSaved = results[indexPath.row]
//        cell.textLabel?.text = heroSaved.localizedName
        return cell
    
    }
    

}

