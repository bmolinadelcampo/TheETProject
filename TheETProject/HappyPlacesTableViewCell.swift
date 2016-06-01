//
//  HappyPlacesTableViewCell.swift
//  TheETProject
//
//  Created by Belén Molina del Campo on 01/06/2016.
//  Copyright © 2016 Belén Molina del Campo. All rights reserved.
//

import UIKit

class HappyPlacesTableViewCell: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var countryLabel: UILabel!
    
    var place: HappyPlace!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    func configureCell(place: HappyPlace) {
        
        self.place = place
        
        if let name = place.name {
            
            nameLabel.text = name
        }
        
        if let country = place.country {
            
            countryLabel.text = country
        }
    }

}
