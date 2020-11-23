//
//  SearchViewController.swift
//  D2.Heroes
//
//  Created by Игорь Попов on 19.11.2020.
//  Copyright © 2020 AirIgor. All rights reserved.
//

import UIKit
import Alamofire
import SDWebImage

class AllHeroesListViewController: UITableViewController {
    
    
    var networkHeroesManager = NetworkHeroesManager()
    var heroesDataManager = [HeroesDataManager]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        view.backgroundColor = .white
        
        
    }
    
    
    private func setupTableView() {
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cellId")
        let nib = UINib(nibName: "HeroCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: HeroCell.reuseId)
        getHeroesList()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return heroesDataManager.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: HeroCell.reuseId, for: indexPath) as! HeroCell
        let hero = heroesDataManager[indexPath.row]
        let url = URL(string: "https://api.opendota.com" + hero.img)
        cell.heroImageView.sd_setImage(with: url, completed: nil)
        cell.heroName.text = hero.localizedName
        cell.attackType.text = hero.attackType
        cell.attributeType.text = hero.primaryAttr
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 84
    }
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedHero = DetailHerosViewController()
        selectedHero.detailHero = heroesDataManager[indexPath.row]
        navigationController?.pushViewController(selectedHero, animated: true)
        }
    

    
    private func getHeroesList() {
        self.networkHeroesManager.getHeroesList { [weak self] (heroDataManager) in
            self?.heroesDataManager = heroDataManager ?? []
            self?.tableView.reloadData()
        }
        
    }
    
}
