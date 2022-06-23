//
//  DetailViewController.swift
//  Meli Challenge
//
//  Created by Francisco Tomas Nasich on 14/06/2022.
//

import UIKit

protocol DetailDelegate {
    func loadProductData(product: MultiGet)
}

class DetailViewController: UIViewController {
    
    @IBOutlet weak var soldAndCondition: UILabel!
    @IBOutlet weak var titleProduct: UILabel!
    @IBOutlet weak var imageProduct: UIImageView!
    @IBOutlet weak var priceProduct: UILabel!
    @IBOutlet weak var quantityButton: UIButton!
    @IBOutlet weak var buyNowButton: UIButton!
    @IBOutlet weak var favButton2: UIButton!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    var detailId: String?
    private var viewModelDescription: DescriptionViewModel?
    private var viewModelDetail: DetailViewModel?
    private var isCouponFav = UserDefaults.standard.bool(forKey: "isCouponFav")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationBarStyle()
        
        if let id = detailId {
                    self.viewModelDescription = DescriptionViewModel(service: DescriptionService(), productId: id)
            self.viewModelDetail = DetailViewModel(service: DetailService(), productId: id, delegate: self)
            self.viewModelDescription?.getDescription()
            self.viewModelDetail?.getDetails()
                }
        
        quantityButton.layer.cornerRadius = 6
        buyNowButton.layer.cornerRadius = 6
    }
    
    func configureUI() {
         let image = UIImage(systemName: "heart")
         let imageFilled = UIImage(systemName: "heart.fill")
        favButton2.setImage(image, for: .normal)
        favButton2.setImage(imageFilled, for: .selected)
     }
    
    @IBAction func favoritesButton(_ sender: UIButton) {
        if isCouponFav {
            let image = UIImage(systemName: "heart")
            sender.setImage(image, for: .normal)
        } else {
            let image = UIImage(systemName: "heart.fill")
            sender.setImage(image, for: .normal)
        }

        isCouponFav = !isCouponFav
        UserDefaults.standard.set(isCouponFav, forKey: "isCouponFav")
        UserDefaults.standard.synchronize()
    }
    
    func navigationBarStyle() {
        self.navigationController?.navigationBar.topItem?.backButtonTitle = ""
        self.navigationController?.navigationBar.tintColor = .black
        self.navigationController!.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController!.navigationBar.shadowImage = UIImage()
        self.navigationController!.navigationBar.isTranslucent = true
    }
    
    func showData(price: Float) -> String {
        let priceInt = Int(price)
        let price = isMultipleOfTen(numero: priceInt)
        var priceString = "$\(String(describing: price))"
        
        switch priceString.count {
        case  5 :
            priceString.insert(".", at: priceString.index(priceString.startIndex, offsetBy: 2))
        case 6 :
            priceString.insert(".", at: priceString.index(priceString.startIndex, offsetBy: 3))
        case 7 :
            priceString.insert(".", at: priceString.index(priceString.startIndex, offsetBy: 4))
        case 8 :
            priceString.insert(".", at: priceString.index(priceString.startIndex, offsetBy: 5))
        default:
            priceString
        }
        
        return priceString
    }
    
    func isMultipleOfTen(numero: Int) -> Int {
        
        if numero.isMultiple(of: 10) {
            return numero
        } else {
            return numero + 1
        }
    }
    
}

extension DetailViewController: DetailDelegate {
    func loadProductData(product: MultiGet) {
        let priceP = product.condition == "new" ? "Nuevo" : "Usado"
        soldAndCondition.text = "\(priceP) | \(product.sold_quantity) vendidos"
        titleProduct.text = product.title
        priceProduct.text = showData(price: product.price)
        quantityButton.titleLabel?.text = "Cantidad: 1  (\(product.available_quantity) disponibles)"
        
        let url = product.pictures[0].url
        let fullUrl = URL(string: url)!
        imageProduct.load(url: fullUrl)
    }
    
    
}
