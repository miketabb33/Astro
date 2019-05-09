//
//  NasaInfoViewController.swift
//  Astro
//
//  Created by Michael Tabb on 5/8/19.
//  Copyright © 2019 Michael Tabb. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import SVProgressHUD

class NasaInfoViewController: UIViewController {
    
    let nasaDataModel = NasaDataModel()
    
    let api_key = "O5XtjFT6wV1o5zLwNDhhwf8giPbWhlasYL24H69p"
    let api_url = "https://api.nasa.gov/planetary/apod"
    
    @IBOutlet weak var nasaImageContainer: UIImageView!
    
    @IBOutlet weak var nasaHeader: UILabel!
    
    @IBOutlet weak var nasaTitle: UILabel!
    
    @IBOutlet weak var nasaDescription: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
    
        SVProgressHUD.show()
        loadNasaData()
        
    }
    
    //MARK - load current nasa information
    
    func loadNasaData() {
        let params : [String : String] = ["api_key" : api_key]
        
        getNasaData(url: api_url, parameters: params)
    }
    
    //MARK - Networking
    
    func getNasaData(url: String, parameters: [String : String]){
        Alamofire.request(url, method: .get, parameters: parameters).responseJSON {
            response in
            if response.result.isSuccess {
                print("Success, got the Nasa data")
                
                let nasaJSON : JSON = JSON(response.result.value!)
                self.updateNasaData(json: nasaJSON)
            } else {
                print("Error \(String(describing: response.result.error))")
                //self.cityLabel.text = "Connection Issues"
            }
        }
    }
    
    //MARK - Json parsing
    func updateNasaData(json: JSON) {
        print(json)
        nasaDataModel.title = json["title"].stringValue
        nasaDataModel.description = json["explanation"].stringValue
        nasaDataModel.imageURL = json["url"].stringValue
        nasaDataModel.date = json["date"].stringValue
        
        updateUIWithNasaData()
    }
    
    //MARK - update UI
    func updateUIWithNasaData(){
        let imageUrlString = nasaDataModel.imageURL
        let imageUrl:URL = URL(string: imageUrlString)!
        
        DispatchQueue.global(qos: .userInitiated).async {
            
            let imageData:NSData = NSData(contentsOf: imageUrl)!
            
            DispatchQueue.main.async {
                SVProgressHUD.dismiss()
                
                self.nasaHeader.text = "Nasa News \(self.nasaDataModel.date)"
                self.nasaTitle.text = self.nasaDataModel.title
                self.nasaDescription.text = self.nasaDataModel.description
                
                let nasaImage = UIImage(data: imageData as Data)
                
                self.nasaImageContainer.image = nasaImage
            }
        }
    }
    
}

