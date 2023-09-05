//
//  TabBarController.swift
//  Anime-App
//
//  Created by Tobi Adegoroye on 27/08/2023.
//

import UIKit

class TabBarViewController: UITabBarController {
    override func viewDidLoad() {
        super.viewDidLoad()

        // Tab Bar Customisation
        view.backgroundColor = .white
        tabBar.unselectedItemTintColor = .systemGray
 
        let vc1 = createTabBarItem(tabBarTitle: "Anime", tabBarImage: "person", viewController: AnimeViewController())
        let vc2 = createTabBarItem(tabBarTitle: "Setting", tabBarImage: "gear", viewController: SettingViewController())


        viewControllers = [vc1,vc2]
        
    }

    func createTabBarItem(tabBarTitle: String, tabBarImage: String, viewController: UIViewController) -> UINavigationController {
        let navCont = UINavigationController(rootViewController: viewController)
        navCont.tabBarItem.title = tabBarTitle
        navCont.tabBarItem.image = UIImage(systemName: tabBarImage)
        // Nav Bar Customisation
        return navCont
    }
}
