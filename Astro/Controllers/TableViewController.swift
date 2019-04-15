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
    let decimalFormatter = NumberFormatter()
    
    var enteredWeight : Int?
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadPlanetData()
        
        askForWeightAlert()
        
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
        
        decimalFormatter.numberStyle = .decimal
        decimalFormatter.maximumFractionDigits = 2
        
        let currentPlanet = planetsContainer[indexPath.row]
        
        if enteredWeight != nil {
            let weight = ((currentPlanet.relativeWeight! as Decimal) * Decimal(enteredWeight!)) as Any?
            if let value = weight {
                let stringWeight = decimalFormatter.string(from: value as! NSNumber)
                cell.weightLabel.text = "\(stringWeight!) lbs"
            }
            
        }
        
        cell.planetName.text = currentPlanet.name!
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
    
   
    func askForWeightAlert() {
        var textfield = UITextField()
        
        let alert = UIAlertController(title: "Enter A Weight", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Enter", style: .default) { (action) in
            //Add if/else for type checking here
            self.enteredWeight = Int(textfield.text!)
            self.tableView.reloadData()
        }
        
        alert.addTextField { (alertTextFeild) in
        alertTextFeild.placeholder = "Enter a weight"
        textfield = alertTextFeild
        }
        
        alert.addAction(action)
        
        present(alert, animated: true, completion: nil)
    }
    

}
