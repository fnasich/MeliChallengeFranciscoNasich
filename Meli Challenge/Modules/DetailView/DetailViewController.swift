//
//  DetailViewController.swift
//  Meli Challenge
//
//  Created by Francisco Tomas Nasich on 14/06/2022.
//

import UIKit

class DetailViewController: UIViewController {
    @IBOutlet weak var titleProduct: UILabel!
    @IBOutlet weak var imageProduct: UIImageView!
    @IBOutlet weak var priceProduct: UILabel!
    @IBOutlet weak var preguntarButton: UIButton!
    @IBOutlet weak var whatsappButton: UIButton!
    
    var detail: MultiGet?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        showData()
        navigationBarStyle()
        preguntarButton.layer.cornerRadius = 6
        whatsappButton.layer.cornerRadius = 6
    }
    
    func navigationBarStyle() {
        self.navigationController?.navigationBar.backIndicatorImage = UIImage(systemName: "chevron.left")
        self.navigationController?.navigationBar.topItem?.backButtonTitle = ""
        self.navigationController?.navigationBar.tintColor = .black
        self.navigationController!.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController!.navigationBar.shadowImage = UIImage()
        self.navigationController!.navigationBar.isTranslucent = true
    }
    
    func showData() {
        let priceInt = Int((detail?.price)!)
        let price = isMultipleOfTen(numero: priceInt)
        
        titleProduct.text = self.detail?.title
        priceProduct.text = "$\(String(describing: price))"
        
        if let url = detail?.pictures[0].url, let fullUrl = URL(string: url) {
            imageProduct.load(url: fullUrl)
        }
    }
    
    func isMultipleOfTen(numero: Int) -> Int {
        if numero.isMultiple(of: 10) {
            return numero
        } else {
            return numero + 1
        }
    }
    
}
