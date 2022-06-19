//
//  TabBar.swift
//  Meli Challenge
//
//  Created by Francisco Tomas Nasich on 14/06/2022.
//

import UIKit

class TabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let activitiesNavigationController = addView(tabTitle: "Inicio", tabImageName: "house", viewController: StartViewController.self)
        viewControllers = [activitiesNavigationController]
        let favorites = addView(tabTitle: "Favoritos", tabImageName: "heart", viewController: StartViewController.self)
        let compras = addView(tabTitle: "Favoritos", tabImageName: "bag", viewController: StartViewController.self)
        let notificaciones = addView(tabTitle: "Favoritos", tabImageName: "bell", viewController: StartViewController.self)
        let mas = addView(tabTitle: "Favoritos", tabImageName: "line.3.horizontal", viewController: StartViewController.self)
        viewControllers = [activitiesNavigationController, favorites, compras, notificaciones, mas]
        
        self.tabBar.isTranslucent = false
        self.tabBar.backgroundColor = UIColor.white
    }
    
    private func addView <T: UIViewController>(tabTitle: String, tabImageName: String, viewController: T.Type) -> UINavigationController {
        
        let nibName = viewController.description().components(separatedBy: ".").last
        
        let vc = viewController.init(nibName: nibName, bundle: nil)
        
        vc.title = nil
        vc.tabBarItem = UITabBarItem(title: tabTitle, image: UIImage(systemName: tabImageName), selectedImage: nil)
        
        let navigationController = UINavigationController(rootViewController: vc)
        navigationController.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 0, weight: UIFont.Weight.bold)]
        
        return navigationController
        
    }
    
}

