//
//  TableViewController.swift
//  Astro
//
//  Created by Michael Tabb on 4/9/19.
//  Copyright © 2019 Michael Tabb. All rights reserved.
//

import UIKit
import CoreData

class TableViewController: UITableViewController {
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var planetsContainer = [Planets]()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.loadPlanetData()
        
      
        
        //DB Directory
        //print(FileManager.default.urls(for: .documentDirectory, in: .userDomainMask))
        
        tableView.register(UINib(nibName: "PlanetCell", bundle: nil), forCellReuseIdentifier: "CustomPlanetCell")
    }
    
    //MARK - Init Table

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return planetsContainer.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CustomPlanetCell", for: indexPath) as! PlanetCell
        
        let currentPlanet = planetsContainer[indexPath.row]
        
        cell.planetName.text = currentPlanet.name
        cell.planetCellImage.image = UIImage(named: currentPlanet.name!)
        
        tableView.rowHeight = 80
        
        return cell
    }
    
    //MARK - loading data from planets database
    
    func loadPlanetData() {
        let request : NSFetchRequest<Planets> = Planets.fetchRequest()
        let sortDescriptor = NSSortDescriptor(key: "position", ascending: true)
        request.sortDescriptors = [sortDescriptor]
        
        do {
            planetsContainer = try context.fetch(request)
        } catch {
            print("Error fetching data from context \(error)")
        }
        
        tableView.reloadData()
    }
    
   
    
    

}
