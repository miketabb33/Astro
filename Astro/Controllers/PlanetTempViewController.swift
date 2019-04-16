//
//  PlanetTempViewController.swift
//  Astro
//
//  Created by Michael Tabb on 4/16/19.
//  Copyright © 2019 Michael Tabb. All rights reserved.
//

import UIKit



class PlanetTempViewController: UIViewController {
    
    var receivedPlanetName : String?
    
    @IBOutlet weak var planetName: UILabel!
    
    @IBOutlet weak var planetImage: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        planetName.text = receivedPlanetName
        planetImage.image = UIImage(named: receivedPlanetName!)
        
    }

}
