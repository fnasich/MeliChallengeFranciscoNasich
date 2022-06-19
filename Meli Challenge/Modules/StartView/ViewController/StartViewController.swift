//
//  StartViewController.swift
//  Meli Challenge
//
//  Created by Francisco Tomas Nasich on 14/06/2022.
//

import UIKit
protocol StartViewDelegate {
    func loadData()
    func dataSearch()
}

class StartViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate {
    
    @IBOutlet weak var searchLabel: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    
    private var viewModel: StartViewModel?
    var service = StartViewService()
    var service2 = Top20Service()
    var service3 = MultiGetService()
    
    
    let arreglo = ["Wolkswagen Polo", "Audi R8", "Audi TT", "Citroen C4 Lounge", "Peugeot 208"]
    var searchArreglo: [String]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView?.delegate = self
        self.tableView?.dataSource = self
        self.searchLabel.delegate = self
        self.tableView.register(UINib(nibName: "StartTableViewCell", bundle: nil), forCellReuseIdentifier: "cell")
        searchArreglo = arreglo
        searchLabel.searchTextField.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1)
        viewModel = StartViewModel(service: service, delegate: self, service2: service2, service3: service3)
        //        viewModel?.getCategory()
    }
    
    
    // MARK: Number Of Rows In Section
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arreglo.count
    }
    
    // MARK: Cell For Row
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? StartTableViewCell
        cell?.label?.text = arreglo[indexPath.row]
        
        return cell ?? StartTableViewCell()
    }
    
    @IBAction func searchButton(_ sender: Any) {
        
    }
    
    // MARK: Did Select Row
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        //        let product = arreglo[indexPath.row]
        //        let productDetail = DetailViewController()
        
    }
    
    
    // MARK: Search Bar
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        searchArreglo = []
        if searchText == "" {
            searchArreglo = arreglo
        } else {
            for car in arreglo {
                if car.lowercased().contains(searchText.lowercased()) {
                    searchArreglo.append(car)
                }
            }
        }
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        SearchTextManager.shared.searchValue = searchLabel.text!.lowercased()
        viewModel?.getCategory()
    }
}

extension StartViewController: StartViewDelegate {
    func dataSearch() {
    }
    
    func loadData() {
        tableView.reloadData()
    }
    
    
}
