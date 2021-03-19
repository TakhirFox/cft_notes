//
//  MainVC.swift
//  cft_notes
//
//  Created by Zakirov Tahir on 13.03.2021.
//

import UIKit

class MainVC: UITabBarController, UITabBarControllerDelegate {
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.delegate = self
        viewControllers = [
            createNavConroller(viewController: NoteListController(collectionViewLayout: UICollectionViewFlowLayout()), title: "Заметки", image: "house")
        ]
        
    }
    
    fileprivate func createNavConroller(viewController: UIViewController, title: String, image: String) -> UIViewController {
        let navController = UINavigationController(rootViewController: viewController)
        navController.tabBarController?.title = title
        navController.tabBarItem.image = UIImage(systemName: image)
        viewController.navigationItem.title = title
        navController.navigationBar.prefersLargeTitles = true
        return navController
    }
    
}
