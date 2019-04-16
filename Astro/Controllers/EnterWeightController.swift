//
//  EnterWeightController.swift
//  Astro
//
//  Created by Michael Tabb on 4/15/19.
//  Copyright © 2019 Michael Tabb. All rights reserved.
//

import UIKit

class EnterWeightController: UIViewController {
    
    
    @IBOutlet weak var enteredWeight: UITextField!
    
   
    @IBOutlet weak var validationError: UILabel!
    
  
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    @IBAction func weightForPlanetsButtonPressed(_ sender: UIButton) {
        
        if Int(enteredWeight.text!) != nil {
            performSegue(withIdentifier: "goToPlanetWeightScreen", sender: self)
        } else {
            validationError.text = "Enter A Number"
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationNavigationController = segue.destination as! UINavigationController
        let targetController = destinationNavigationController.viewControllers.first as! TableViewController
        
        targetController.enteredWeight = Int(enteredWeight.text!)
    }
    
}
