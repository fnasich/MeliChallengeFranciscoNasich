//
//  StartViewController.swift
//  Meli Challenge
//
//  Created by Francisco Tomas Nasich on 14/06/2022.
//

import UIKit

//MARK: Protocol Start View Delegate
protocol StartViewDelegate {
    func loadData()
    func showMessage(message:String)
    func isMultipleOfTen(numero: Int) -> Int
    func showData(price: Float) -> String
}

class StartViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate {
    
    @IBOutlet weak var searchLabel: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var cartButton: UIImageView!
    
    private var viewModel: StartViewModel?
    var service = StartViewService()
    var service2 = Top20Service()
    var service3 = MultiGetService()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUp()
    }
    
    // MARK: Set Up function
    func setUp(){
        self.tableView?.delegate = self
        self.tableView?.dataSource = self
        self.searchLabel.delegate = self
        self.tableView.register(UINib(nibName: "StartTableViewCell", bundle: nil), forCellReuseIdentifier: "cell")
        searchLabel.searchTextField.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1)
        viewModel = StartViewModel(service: service, delegate: self, service2: service2, service3: service3)
    }
    
    
    // MARK: Number Of Rows In Section
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.top20Count() ?? 0
    }
    
    // MARK: Cell For Row
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! StartTableViewCell
        let priceInt = viewModel?.productList(at: indexPath.row).price
        
        cell.titleProduct?.text = self.viewModel?.productList(at: indexPath.row).title
        cell.priceProduct.text = showData(price: priceInt!)
        cell.condition.text = self.viewModel?.productList(at: indexPath.row).condition  == "new" ? "Nuevo" : "Usado"
        cell.location.text = self.viewModel?.productList(at: indexPath.row).seller_address.search_location.state.name
        
        if let url = self.viewModel?.productList(at: indexPath.row).pictures[0].url, let fullUrl = URL(string: url) {
            cell.imageCar.load(url: fullUrl)
        }
        
        return cell
    }
    
    // MARK: Did Select Row
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let productDetail = DetailViewController()
        let product = self.viewModel?.productList(at: indexPath.row).id
        productDetail.detailId = product
        navigationController?.pushViewController(productDetail, animated: true)
    }
    
    // MARK: Search Bar Text Begin Editing
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchBar.showsCancelButton = true
        searchBar.tintColor = .black
        cartButton.isHidden = true
    }
    
    // MARK: Search Bar Cancel Button Clicked
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text = nil
    }
    
    // MARK: Search Bar Button Clicked
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        SearchTextManager.shared.searchValue = searchLabel.text!.lowercased()
        viewModel?.getCategory()
    }
}

extension StartViewController: StartViewDelegate {
    func loadData() {
        tableView.reloadData()
    }
    
    func showMessage(message:String) {
        let alert = UIAlertController(title: "Ha ocurrido un error", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    func isMultipleOfTen(numero: Int) -> Int {
        if numero.isMultiple(of: 10) {
            return numero
        } else {
            return numero + 1
        }
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
}
