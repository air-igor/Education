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
    
    var coctailList = [Drinks]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let nibb = UINib.init(nibName: "CustomTableViewCellTwo", bundle: nil)
        let nibbb = UINib.init(nibName: "CustomTableViewCellThree", bundle: nil)
        let nib = UINib.init(nibName: "CustomTableViewCell", bundle: nil)
        self.cocktailTable.register(nib, forCellReuseIdentifier: "CustomTableViewCell")
        self.cocktailTable.register(nibb, forCellReuseIdentifier: "CustomTableViewCellTwo")
        self.cocktailTable.register(nibbb, forCellReuseIdentifier: "CustomTableViewCellThree")
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        coctailList.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CustomTableViewCell", for: indexPath) as! CustomTableViewCell
        cell.nameCocktail.text = coctailList[indexPath.row].strDrink
        cell.imageCocktail.image = #imageLiteral(resourceName: "CoctailDetails")
        
        return cell
    }
   
}
