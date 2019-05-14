//
//  NasaInfoViewController.swift
//  Astro
//
//  Created by Michael Tabb on 5/8/19.
//  Copyright © 2019 Michael Tabb. All rights reserved.
//

import UIKit
import SVProgressHUD

class NasaInfoViewController: UIViewController {
    
    @IBOutlet weak var nasaImageContainer: UIImageView!
    
    @IBOutlet weak var nasaHeader: UILabel!
    
    @IBOutlet weak var nasaTitle: UILabel!
    
    @IBOutlet weak var nasaDescription: UILabel!
    
    var nasaDataModel = NasaDataModel()

    override func viewDidLoad() {
        super.viewDidLoad()
    
        //SVProgressHUD.show()
        
        //To Do: Figure a way to trigger updateUIWithNasaData() after the model is finished loading data while on this page.
        
        if nasaDataModel.imageData == nil {
            nasaTitle.text = "DOPE!"
        } else {
            updateUIWithNasaData()
        }
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if nasaTitle.text == "DOPE!" && nasaDataModel.imageData != nil {
            updateUIWithNasaData()
        }
    }
    
    
    
    //MARK - update UI
    func updateUIWithNasaData(){
        nasaHeader.text = "Nasa News \(nasaDataModel.date)"
        nasaTitle.text = nasaDataModel.title
        nasaDescription.text = nasaDataModel.description
        nasaImageContainer.image = nasaDataModel.imageData
    }
    
}

