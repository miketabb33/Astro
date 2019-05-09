//
//  NasaDetailViewController.swift
//  Astro
//
//  Created by Michael Tabb on 4/17/19.
//  Copyright © 2019 Michael Tabb. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import SVProgressHUD

class NasaDetailViewController: UIViewController {
    
    
    
    @IBOutlet weak var nasaTitle: UILabel!
    
    @IBOutlet weak var nasaDescription: UILabel!
    
    var passedTitle: String = ""
    var passedDescription: String = ""
    var passedImage: NSData?
    
    public var screenWidth: CGFloat {
        return UIScreen.main.bounds.width
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateUIWithNasaData()
        
    }
    

    func updateUIWithNasaData(){
        let imageData = passedImage!
        self.nasaTitle.text = self.passedTitle
        self.nasaDescription.text = self.passedDescription
        
        let imageContainer = UIImageView(frame: CGRect(x:0, y:0, width:screenWidth, height:screenWidth))
        let nasaImage = UIImage(data: imageData as Data)
        imageContainer.image = nasaImage
        imageContainer.contentMode = UIView.ContentMode.scaleAspectFit
        self.view.addSubview(imageContainer)
    }


}
