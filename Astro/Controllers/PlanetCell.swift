//
//  PlanetCell.swift
//  Astro
//
//  Created by Michael Tabb on 4/10/19.
//  Copyright © 2019 Michael Tabb. All rights reserved.
//

import UIKit

class PlanetCell: UITableViewCell {
    
    @IBOutlet weak var planetName: UILabel!
    
    @IBOutlet weak var planetCellImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
