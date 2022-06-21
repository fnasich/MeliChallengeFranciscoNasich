//
//  StartViewController.swift
//  Meli Challenge
//
//  Created by Francisco Tomas Nasich on 14/06/2022.
//

import UIKit
protocol StartViewDelegate {
    func loadData()
    func showMessage(message:String)
}

class StartViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate {
    
    @IBOutlet weak var searchLabel: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    
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
        cell.titleProduct?.text = self.viewModel?.productList(at: indexPath.row).title
        cell.priceProduct.text = "\(String(describing: self.viewModel!.productList(at: indexPath.row).price))"
        cell.condition.text = self.viewModel?.productList(at: indexPath.row).condition
        
        cell.location.text = self.viewModel?.productList(at: indexPath.row).seller_address.search_location.state.name
        
        
        if let url = self.viewModel?.productList(at: indexPath.row).pictures[0].url, let fullUrl = URL(string: url) {
            cell.imageCar.load(url: fullUrl)
        }
        
        return cell
    }
    
    // MARK: Did Select Row
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        //        let product = self.viewModel?.productList(at: indexPath.row)
        //        let productDetail = DetailViewController()
        
    }
    
    // MARK: Search Bar Button Clicked
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        SearchTextManager.shared.searchValue = searchLabel.text!.lowercased()
        //        SearchTextManager.shared.multiGetId.removeAll()
        viewModel?.getCategory()
    }
}

extension StartViewController: StartViewDelegate {
    
    func loadData() {
        tableView.reloadData()
    }
    
    func showMessage(message:String) {
        let alert = UIAlertController(title: "An error has been ocurred", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}
