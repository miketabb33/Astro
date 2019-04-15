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
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func weightForPlanetsButtonPressed(_ sender: UIButton) {
        performSegue(withIdentifier: "goToPlanetWeightScreen", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationNavigationController = segue.destination as! UINavigationController
        let targetController = destinationNavigationController.viewControllers.first as! TableViewController
        
        targetController.enteredWeight = Int(enteredWeight.text!)
        
        
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
