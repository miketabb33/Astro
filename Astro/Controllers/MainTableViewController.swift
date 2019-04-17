//
//  MainTableViewController.swift
//  Astro
//
//  Created by Michael Tabb on 4/16/19.
//  Copyright © 2019 Michael Tabb. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import SVProgressHUD

class MainTableViewController: UITableViewController {
    
    var mainItemsArray = ["How much do you weigh on The Moon?", "What's the weather on Mars?"]
    
    let nasaDataModel = NasaDataModel()
    
    let api_key = "O5XtjFT6wV1o5zLwNDhhwf8giPbWhlasYL24H69p"
    let api_url = "https://api.nasa.gov/planetary/apod"
    
    public var screenWidth: CGFloat {
        return UIScreen.main.bounds.width
    }
    
    @IBOutlet weak var nasaHeader: UILabel!
    
    @IBOutlet weak var nasaTitle: UILabel!
    
    @IBOutlet weak var nasaDescription: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        SVProgressHUD.show()
        loadNasaData()

        tableView.register(UINib(nibName: "MainItemCell", bundle: nil), forCellReuseIdentifier: "CustomMainItemCell")
    }

    //MARK - Table View data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return mainItemsArray.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CustomMainItemCell", for: indexPath) as! MainItemCell

        cell.title.text = mainItemsArray[indexPath.row]
        cell.accessoryType = .disclosureIndicator

        return cell
    }
    
    //MARK - Navigation
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0{
            performSegue(withIdentifier: "toWeightOnOtherPlanets", sender: self)
        } else if indexPath.row == 1{
            performSegue(withIdentifier: "toPlanetTempList", sender: self)
        }
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
                
                let imageSize = (self.screenWidth/10) * 7
                let imagePosition = (self.screenWidth/2) - (imageSize/2)
                let imageContainer = UIImageView(frame: CGRect(x:imagePosition, y:8, width:imageSize, height:imageSize))
                let nasaImage = UIImage(data: imageData as Data)
                imageContainer.image = nasaImage
                imageContainer.contentMode = UIView.ContentMode.scaleAspectFit
                self.view.addSubview(imageContainer)
            }
        }
    }
    
}




