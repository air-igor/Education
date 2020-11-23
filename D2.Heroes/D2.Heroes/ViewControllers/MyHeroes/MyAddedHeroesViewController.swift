//
//  HomeHeroesViewController.swift
//  D2.Heroes
//
//  Created by Игорь Попов on 19.11.2020.
//  Copyright © 2020 AirIgor. All rights reserved.
//

import UIKit
import CoreData

class MyAddedHeroesViewController: UITableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        fetchData()
    }
    
    private var addHeroArray: [Hero] = []
    private let manageContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    //    MARK: Setup TableViewCell and NavigationBar
    private func setupTableView() {
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cellAdd")
        tableView.tableFooterView = UIView()
        
        setupNavigationBar()
    }
    
    private func setupNavigationBar() {
        title = "My heroes"
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Add hero",
                                                            style: .plain,
                                                            target: self,
                                                            action: #selector(addNewHero)
        )
    }
    
    // Button AddHero
    @objc private func addNewHero() {
        showAlert(title: "Add new hero", message: "Add the name of your favorite hero from DotA 2")
    }
    
    //    MARK: TableView Settings
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return addHeroArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellAdd", for: indexPath)
        
        let myAddHero = addHeroArray[indexPath.row]
        cell.textLabel?.text = myAddHero.name
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellAdd", for: indexPath)
        
        let myAddHero = addHeroArray[indexPath.row]
        showAlert(title: "Edit hero name",
                  message: "Enter new name",
                  currentHero: myAddHero) { (newValue) in
                    
                    cell.textLabel?.text = newValue
                    self.tableView.reloadRows(at: [indexPath], with: .automatic)
        }
    }
    
    //    Delete hero name
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        let myAddHero = addHeroArray[indexPath.row]
        
        if editingStyle == .delete {
            deleteHero(myAddHero, indexPath: indexPath)
        }
    }
    
    // MARK: Core Data
    private func save(_ taskName: String) {
        //        Entity name
        guard let entityDescription = NSEntityDescription.entity(forEntityName: "Hero", in: manageContext) else { return }
        
        //        Model instance
        let task = NSManagedObject(entity: entityDescription, insertInto: manageContext) as! Hero
        
        task.name = taskName
        
        do {
            try manageContext.save()
            addHeroArray.append(task)
            self.tableView.insertRows(
                at: [IndexPath(row: self.addHeroArray.count - 1, section: 0)],
                with: .automatic
            )
        } catch let error {
            print(error.localizedDescription)
        }
    }
    
    private func fetchData() {
        
        //        Запрос выборки из базы всех значений по ключу Hero
        let fetchRequest: NSFetchRequest<Hero> = Hero.fetchRequest()
        
        do {
            addHeroArray = try manageContext.fetch(fetchRequest)
        } catch let error {
            print(error.localizedDescription)
        }
    }
    
    private func editHero(_ addMyHero: Hero, newName: String) {
        do {
            addMyHero.name = newName
            try manageContext.save()
        } catch let error {
            print(error.localizedDescription)
        }
    }
    
    //    Delete hero name
    private func deleteHero(_ addMyHero: Hero, indexPath: IndexPath) {
        manageContext.delete(addMyHero)
        
        do {
            try manageContext.save()
            addHeroArray.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
        } catch let error {
            print(error.localizedDescription)
        }
    }
    
    //   MARK: Show Alert
    private func showAlert(title: String,
                           message: String,
                           currentHero: Hero? = nil,
                           completion: ((String) -> Void)? = nil) {
        
        let alert = UIAlertController(title: title,
                                      message: message,
                                      preferredStyle: .alert)
        //        Save action
        let saveAction = UIAlertAction(title: "Save", style: .default) { _ in
            guard let newValue = alert.textFields?.first?.text else { return }
            guard !newValue.isEmpty else { return }
            
            //            Edit current task or add new task
            currentHero != nil ? self.editHero(currentHero!, newName: newValue) : self.save(newValue)
            if completion != nil { completion!(newValue) }
            
        }
        
        //        Cancel action
        let cancelAction = UIAlertAction(title: "Cancel", style: .destructive) {_ in
            // Animated selected indexPath when editing name hero
            if let indexPath = self.tableView.indexPathForSelectedRow {
                self.tableView.deselectRow(at: indexPath, animated: true)
            }
        }
        
        
        
        alert.addTextField()
        alert.addAction(saveAction)
        alert.addAction(cancelAction)
        
        if currentHero != nil {
            alert.textFields?.first?.text = currentHero?.name
        }
        present(alert, animated: true)
    }
    
}
