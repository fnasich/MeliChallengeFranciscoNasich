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
    
    var detail: MultiGet?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        showData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    @IBAction func backButton
    (_ sender: Any) {
        let tabBar = StartViewController()
        navigationController?.pushViewController(tabBar, animated: true)
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
