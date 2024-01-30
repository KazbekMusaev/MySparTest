//
//  TabBarController.swift
//  MySparTest
//
//  Created by apple on 30.01.2024.
//

import UIKit

class TabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let mainController = UINavigationController(rootViewController: ViewController())
        mainController.tabBarItem.image = UIImage(systemName: "tree.fill")
        mainController.tabBarItem.title = "Главная"
        //Тут я буду их называть второй, третий и тд. Так как они не нужны, просто без них не могу составить полную картину
        let secondController = SecondController()
        secondController.tabBarItem.title = "Каталог"
        secondController.tabBarItem.image = UIImage(systemName: "square.split.2x2.fill")
        let thirdController = ThirdController()
        thirdController.tabBarItem.title = "Корзина"
        thirdController.tabBarItem.image = UIImage(systemName: "basket")
        let fourContoller = FourController()
        fourContoller.tabBarItem.title = "Профиль"
        fourContoller.tabBarItem.image = UIImage(systemName: "person")
        viewControllers = [mainController, secondController, thirdController, fourContoller]
        tabBar.backgroundColor = .ourWhiteColor
        tabBar.tintColor = .ourGreenColor
    }
    


}
