//
//  StartTableViewCell.swift
//  Meli Challenge
//
//  Created by Francisco Tomas Nasich on 14/06/2022.
//

import UIKit

class StartTableViewCell: UITableViewCell {
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var imageCar: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
