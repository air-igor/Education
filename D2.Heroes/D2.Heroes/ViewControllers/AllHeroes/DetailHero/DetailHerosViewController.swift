//
//  DetailHerosViewController.swift
//  D2.Heroes
//
//  Created by Игорь Попов on 21.11.2020.
//  Copyright © 2020 AirIgor. All rights reserved.
//

import UIKit
import SDWebImage

class DetailHerosViewController: UITableViewController {
    
    var detailHero: HeroEntry!
    var heroesManager = [HeroEntry]()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        
    }
    
    private func setupTableView() {
    tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cellAdd")
        let nib = UINib(nibName: "DetailCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: DetailCell.reuseId)
        tableView.tableFooterView = UIView()
        setupNavigationBar()
    }
    
    private func setupNavigationBar() {
        title = "Detail hero information"
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        205
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: DetailCell.reuseId, for: indexPath) as! DetailCell
        let url = URL(string: "https://api.opendota.com" + detailHero.img!)
        let urlIcon = URL(string: "https://api.opendota.com" + detailHero.icon!)
        cell.heroImg.sd_setImage(with: url, completed: nil)
        cell.nameLbl.text = detailHero.localizedName
        cell.healthLbl.text = "\(detailHero.baseHealth)"
        cell.manaLbl.text = "\(detailHero.baseMana)"
        cell.moveSpeedLbl.text = "\(detailHero.moveSpeed)"
        cell.strLbl.text = "\(detailHero.baseStr)"
        cell.agiLbl.text = "\(detailHero.baseAgi)"
        cell.intLbl.text = "\(detailHero.baseInt)"
        cell.iconImage.sd_setImage(with: urlIcon, completed: nil)

        return cell
    }
    
    
}
