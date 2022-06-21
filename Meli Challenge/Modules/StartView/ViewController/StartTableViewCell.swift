//
//  StartTableViewCell.swift
//  Meli Challenge
//
//  Created by Francisco Tomas Nasich on 14/06/2022.
//

import UIKit

class StartTableViewCell: UITableViewCell {
    @IBOutlet weak var titleProduct: UILabel!
    @IBOutlet weak var priceProduct: UILabel!
    
    @IBOutlet weak var imageCar: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
//    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
//        // get the current text, or use an empty string if that failed
//        let currentText = textField.text ?? ""
//
//        // attempt to read the range they are trying to change, or exit if we can't
//        guard let stringRange = Range(range, in: currentText) else { return false }
//
//        // add their new text to the existing text
//        let updatedText = currentText.replacingCharacters(in: stringRange, with: string)
//
//        // make sure the result is under 16 characters
//        return updatedText.count <= 16
//    }
    
}
