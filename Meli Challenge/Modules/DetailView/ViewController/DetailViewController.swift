//
//  DetailViewController.swift
//  Meli Challenge
//
//  Created by Francisco Tomas Nasich on 14/06/2022.
//

import UIKit

// MARK: Protocol Detail Delegate
protocol DetailDelegate {
    func loadProductData(product: MultiGet)
    func spinnerLoadingState(state: Bool)
}

class DetailViewController: UIViewController {
    
    @IBOutlet weak var soldAndCondition: UILabel!
    @IBOutlet weak var titleProduct: UILabel!
    @IBOutlet weak var imageProduct: UIImageView!
    @IBOutlet weak var priceProduct: UILabel!
    @IBOutlet weak var quantityButton: UIButton!
    @IBOutlet weak var buyNowButton: UIButton!
    @IBOutlet weak var descriptionText: UITextView!
    
    // MARK: Id product from StartViewController
    var detailId: String?
    private var viewModelDescription: DescriptionViewModel?
    private var viewModelDetail: DetailViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationBarStyle()
        spinnerLoadingState(state: true)
        
        if let id = detailId {
            self.viewModelDescription = DescriptionViewModel(service: DescriptionService(), productId: id)
            self.viewModelDetail = DetailViewModel(service: DetailService(), productId: id, delegate: self)
            self.viewModelDescription?.getDescription()
            self.viewModelDetail?.getDetails()
        }
    }
    
    //MARK: ConfigureUI
    func configureUI() {
        quantityButton.layer.cornerRadius = 6
        buyNowButton.layer.cornerRadius = 6
    }
    
    //MARK: Navigation Bar Style
    func navigationBarStyle() {
        self.navigationController?.navigationBar.topItem?.backButtonTitle = ""
        self.navigationController?.navigationBar.tintColor = .black
        self.navigationController!.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController!.navigationBar.shadowImage = UIImage()
        self.navigationController!.navigationBar.isTranslucent = true
    }
    
    //MARK: Multiple of Ten Function
    func isMultipleOfTen(numero: Int) -> Int {
        if numero.isMultiple(of: 10) {
            return numero
        } else {
            return numero + 1
        }
    }
    
    //MARK: Number Dot Digit Function
    //Separa con punto los numeros segun la cantidad de digitos
    func numberDotDigit(price: Float) -> String {
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
}

extension DetailViewController: DetailDelegate {
    func loadProductData(product: MultiGet) {
        let priceP = product.condition == "new" ? "Nuevo" : "Usado"
        soldAndCondition.text = "\(priceP) | \(product.sold_quantity) vendidos"
        titleProduct.text = product.title
        priceProduct.text = numberDotDigit(price: product.price)
        quantityButton.titleLabel?.text = "Cantidad: 1  (\(product.available_quantity) disponibles)"
        descriptionText.text = viewModelDescription!.showDecription().description
        
        let url = product.pictures[0].url
        let fullUrl = URL(string: url)!
        imageProduct.load(url: fullUrl)
    }
    
    func spinnerLoadingState(state: Bool) {
        state ? self.showSpinner(onView: self.view) : self.removeSpinner()
    }
}
