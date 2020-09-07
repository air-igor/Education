//
//  DetailSearchViewController.swift
//  CoctailHelper
//
//  Created by Игорь Попов on 03.09.2020.
//  Copyright © 2020 AirIgor. All rights reserved.
//

import UIKit

class DetailSearchViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var cocktailTable: UITableView!
    
    var onLoadingComplete: (() -> Void)?
    
    var coctailList = [Drinks]()
    var coctail: Drinks?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        backSearch()
        registerCells()
        onLoadingComplete?()
        cocktailTable.tableFooterView = UIView()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        return 152
//    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // MARK: CELL NAME COCKTAIL
        if indexPath.row < 1 {
            let cell = tableView.dequeueReusableCell(withIdentifier: CustomTableViewCell.indetifier, for: indexPath) as? CustomTableViewCell
            cell?.nameCocktail.text = coctail?.strDrink
            cell?.imageCocktail.downloaded(from: coctail?.strDrinkThumb ?? "")
            
            
            return cell!
        }
        
        // MARK: CELL INGREDIENTS
        if indexPath.row < 2 {
            let cell = tableView.dequeueReusableCell(withIdentifier: CustomTableViewCellTwo.indetifier, for: indexPath) as? CustomTableViewCellTwo
            cell?.ingredientsLbl?.text = coctail?.ingredients
            
            return cell!
        }
        
        // MARK: CELL INSTRUCTIONS
        let cell = tableView.dequeueReusableCell(withIdentifier: CustomTableViewCellThree.indetifier, for: indexPath) as? CustomTableViewCellThree
        cell?.instructionsLbl?.text = coctail?.strInstructions
        
        return cell!
        
        
    }
    
    
    
    
   @objc func backAction() {
        dismiss(animated: true, completion: nil)
    }
    
    func backSearch() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Back", style: .plain, target: self, action: #selector(backAction))
    }
    
    func registerCells() {
        let nibb = UINib.init(nibName: "CustomTableViewCellTwo", bundle: nil)
        let nibbb = UINib.init(nibName: "CustomTableViewCellThree", bundle: nil)
        let nib = UINib.init(nibName: "CustomTableViewCell", bundle: nil)
        self.cocktailTable.register(nib, forCellReuseIdentifier: "CustomTableViewCell")
        self.cocktailTable.register(nibb, forCellReuseIdentifier: "CustomTableViewCellTwo")
        self.cocktailTable.register(nibbb, forCellReuseIdentifier: "CustomTableViewCellThree")
    }
    
    
}
