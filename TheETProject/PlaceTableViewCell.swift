//
//  PlaceTableViewCell.swift
//  TheETProject
//
//  Created by Belén Molina del Campo on 10/05/2016.
//  Copyright © 2016 Belén Molina del Campo. All rights reserved.
//

import UIKit
import MapKit

class PlaceTableViewCell: UITableViewCell {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var countryLabel: UILabel!
    
    var placemark: MKPlacemark!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func configureCell(placemark: MKPlacemark) {
        if let name = placemark.locality {
            
            nameLabel.text = name as? String
        }
        
        if let country = placemark.country {
            
            countryLabel.text = country as? String
        }
        
        backgroundColor = UIColor.whiteColor()
        
        self.placemark = placemark
    }

}
